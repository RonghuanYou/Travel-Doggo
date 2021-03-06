var city = ""
var defaultFlag = 1
// Note: Use your weatherAPI
// var weatherAPI = "xxx"

// get user input location
const setLocation = (event) => {
    city = event.value
    console.log(city)
}

// get user location in db
async function getUserLocation(){
	let userCity = ""
	await fetch("http://localhost:8080/location")
	.then(res => res.json())
	.then(data => {
		userCity = data.location
	})
	return userCity
}


function getLocationInfo(){
	// fetch current weather info by city
	fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${weatherAPI}`)
		.then(response => response.json())
		.then(data => {
			// console.log(data)
			var html = `
			<h3> ${city}, ${data.sys.country} </h3>
			<h4> ${data.main.temp} °F</h4>
			<p> Weather: ${data.weather[0].main}, ${data.weather[0].description}</p>
			<p> Humidity: ${data.main.humidity}%, Wind Speed: ${data.wind.speed} mph </p>
			<p> Min Temperature: ${data.main.temp_min} °F</p>
			<p> Max Temperature: ${data.main.temp_max} °F</p>
			`
			document.getElementById("display_info").innerHTML = html;

			let lat = data.coord.lat;
			let lon = data.coord.lon;
			// display one week forecast graph
			fetch(`https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&exclude=minutely&units=imperial&appid=${weatherAPI}`)
			.then(response => response.json())
			.then(data => {
				console.log("temp", data)
				console.log("check1", data.daily)
				let tempMin = [], 
					tempMax = [],
					tempAverage = [], 
					myDate = []
					
				for (let i = 0; i < data.daily.length; i++){
					tempMin.push(data.daily[i].temp.min);
					tempMax.push(data.daily[i].temp.max);
					tempAverage.push(data.daily[i].temp.day);
					myDate.push(data.daily[i].dt)
				}
				
				newDate = epochValueToDate(myDate)
				
				var myChart = echarts.init(document.getElementById('forecast'));
				option = {
				     
				    title: {
				        text: 'Incoming Week Forecast',
				      	textStyle: {
				            color: 'rgb(186, 180, 171)',
				            left: 10
				        }
				    },
				    tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				        data: ['Highest Temperature', 'Lowest Temperature'],
		                x: 'right',
				        textStyle: {
				            color: 'rgb(186, 180, 171)',
				            fontSize: 13,
				        }
				    },
				    toolbox: {
				        show: true,
				    },
				    xAxis: {
				        type: 'category',
				        boundaryGap: false,
				        data: newDate
				    },
				    yAxis: {
				        type: 'value',
				        axisLabel: {
				            formatter: '{value} °F'
				        }
				    },
			        
				    series: [
				        {
				            name: 'Highest Temperature',
				            type: 'line',
				            data: tempMax,
				            markPoint: {
				                data: [
				                    {type: 'max', name: 'Max'},
				                ]
				            },
				            markLine: {
				                data: [
				                    {type: 'average', name: 'Average-max'}
				                ]
				            }
				        },
				        {
				            name: 'Lowest Temperature',
				            type: 'line',
				            data: tempMin,
				            markPoint: {
				                data: [
					            	{type: 'min', name: 'Min'}
				                ]
				            },
				            markLine: {
				                data: [
				                    {type: 'average', name: 'Average-min'}
				                ]
				            }
				        }
				    ]
				};	
		        myChart.setOption(option);
			});
						
			let start = "1627110000",
				end = "1629788400";
								

			// previous month air quality value
			fetch(`http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=${start}&end=${end}&appid=${weatherAPI}`)
			.then(response => response.json())
			.then(data => {
				let airQualityData = []
				let AQIMonthSum = 0;
				for (let i = 0; i < data.list.length; i++){
					// get one month data
					if ((data.list[i].dt - start) % 86400 == 0){
						element = data.list[i]
						AQIMonthSum += element.main.aqi
						airQualityData.push([element.main.aqi, element.components.co, element.components.no2, element.components.o3, element.components.so2, element.components.pm2_5, element.components.pm10])
					}
				}
				//  Air Quality Index. 
				var myChart = echarts.init(document.getElementById('main'));
				var lineStyle = {
					    normal: {
					        width: 1,
					        opacity: 0.5
					    }
					};
		
				option = {
					text: "good",
				    backgroundColor: '#161627',
				    title: {
				        text: 'Past Month AQI, Сoncentration of Components in Air',
				        textStyle: {
				            color: 'rgb(186, 180, 171)',
				        }
				    },
				    legend: {
				        bottom: 5,
				        data: [`${city}`],
				        itemGap: 20,
				        textStyle: {
				            color: '#fff',
				            fontSize: 14
				        },
				        selectedMode: 'single'
				    },
		 	
				    radar: {
				        indicator: [
				            {name: 'AQI', max: 10},
				            {name: 'CO', max: 800},
				            {name: 'NO2', max: 100},
				            {name: 'O3', max: 200},
				            {name: 'SO2', max: 70},
				            {name: 'PM2.5', max: 100},
				            {name: 'PM10', max: 100},
				        ],
				        shape: 'circle',
				        splitNumber: 7,
				        name: {
				            textStyle: {
				                color: 'rgb(238, 197, 102)'
				            }
				        },
				        splitLine: {
				            lineStyle: {
				                color: [
				                    'rgba(238, 197, 102, 0.1)', 'rgba(238, 197, 102, 0.2)',
				                    'rgba(238, 197, 102, 0.4)', 'rgba(238, 197, 102, 0.6)',
				                    'rgba(238, 197, 102, 0.8)', 'rgba(238, 197, 102, 1)'
				                ].reverse()
				            }
				        },
				        splitArea: {
				            show: false
				        },
				        axisLine: {
				            lineStyle: {
				                color: 'rgba(238, 197, 102, 0.5)'
				            }
				        }
				    },
				    series: [
				        {
				            name: `${city}`,
				            type: 'radar',
				            lineStyle: lineStyle,
				            data: airQualityData,
				            symbol: 'none',
				            itemStyle: {
				                color: '#F9713C'
				            },
				            areaStyle: {
				                opacity: 0.1
				            }
				        }]
			};
		    // use configuration item and data specified to show chart
	        myChart.setOption(option);
	        
	        // calculate average AQI and pass it into jsp file
	        let averageAQI = (AQIMonthSum/32).toFixed(1);
	        let htmlAQIResult = `<p> Average of previous month AQI = ${averageAQI}</p>`
			document.getElementById("aqi_result").innerHTML = htmlAQIResult;

			console.log(airQualityData)
			})
	    })
	    .catch(err => console.log(err))
}


// default city is user location
async function showDefaultLocation(){
	if (defaultFlag){
		city = await getUserLocation()
		getLocationInfo()
		defaultFlag = 0
	}
}

showDefaultLocation();

// convert epoch unix time to human date (8/10)
function epochValueToDate(epochList){
	myDate = []
	for (let i = 0; i < epochList.length; i++){
		stringDate = new Date(parseInt(epochList[i])*1000).toLocaleString();
		monthDayYear = stringDate.split(",")[0]
		monthDay = monthDayYear.split("/")[0] + "/" + monthDayYear.split("/")[1]
		myDate.push(monthDay)
	}
	return myDate;
}


