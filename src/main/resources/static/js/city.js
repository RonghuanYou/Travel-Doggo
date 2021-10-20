var centerCityCoord = {}
// Note: Use your weatherAPI
// var weatherAPI = "xxx"


// return a list of city names in db
// make sure we use await to get all data from URL, or return list will be empty
async function getCityName(){
	let cityNames = []
	await fetch("http://localhost:8080/cities")
	.then(res => res.json())
	.then(data => {
		console.log(data)
		for (let i = 0; i < data.length; i++){
			cityNames.push(data[i].name)
		}
	})
	return cityNames
}


// get center city name in db and fetch its coord
async function getUserCity(){
	let userCity = ""
	await fetch("http://localhost:8080/location")
	.then(res => res.json())
	.then(data => {
		userCity = data.location
	})
	return userCity
}

async function getUserCityCoord(){
	let userCoord = {};
	let city = await getUserCity()
	
	await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${weatherAPI}`)
	.then(res => res.json())
	.then(data => {
		userCoord = {lat: data.coord.lat, lng: data.coord.lon}
	})
	return userCoord;
}


// generate google map and put markers/info-windows based on coord
async function initMap(){
	var options = {
		zoom: 8,
		center: await getUserCityCoord()
	}
	var map = new google.maps.Map(document.getElementById('map'), options);
	let coordsList = [];
	let cityNames = await getCityName()
		
	// iterate all cities, and get coords by city name
	for (var city of cityNames){
		await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${weatherAPI}`)

		.then(response => response.json())
		.then(data => {
			coordsList.push({lat: data.coord.lat, lng: data.coord.lon})
		})
	}
	
	// invoke addMarker()
	addMarker(coordsList)
	
	// itereate coords and add markers based on specific coord
	function addMarker(coords){
		for (let i = 0; i < coords.length; i++){
			var marker = new google.maps.Marker({
				position: coords[i],
				map: map,
			    //icon: "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png"
			})
		}
	}
}
