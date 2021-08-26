console.log("city.js is connected")

/*
function updateTextInput(val) {
	document.getElementById('textInput').value=val; 
}
*/

// return a list of city names in db
// make sure we use await to get all data from URL, or return list will be empty
async function getCityName(){
	let cityNames = []
	await fetch("http://localhost:8080/cities")
	.then(res => res.json())
	.then(data => {
		for (let i = 0; i < data.length; i++){
			cityNames.push(data[i].name)
		}
	})
	return cityNames
}

// generate google map and put markers/info-windows based on coord
async function initMap(){
	var options = {
		zoom: 8,
		center: {lat: 33.6846, lng: -117.8265}
	}
	var map = new google.maps.Map(document.getElementById('map'), options);
	let coordsList = [];
	let cityNames = await getCityName()
	
	// iterate all cities, and get coords by city name
	for (var city of cityNames){
		await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=a660c205d82c83622a0e4496eb8af773`)
		.then(response => response.json())
		.then(data => {
			coordsList.push({lat: data.coord.lat, lng: data.coord.lon})
		})
	}
	
	// perform the action of adding markers on map
	addMarker(coordsList)
	
	// itereate coords and add markers based on specific coord
	function addMarker(coords){
		for (let i = 0; i < coords.length; i++){
			var marker = new google.maps.Marker({
				position: coords[i],
				map: map
			})
		}
	}
}












