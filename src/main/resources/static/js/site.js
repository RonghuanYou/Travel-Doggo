console.log("js file!");


var city = ""
var defaultFlag = 1

// get user input location
const setLocation = (event) => {
    city = event.value
    console.log(city)
}


function getLocationInfo(){
	// fetch current weather info by city
	fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=a660c205d82c83622a0e4496eb8af773`)
		.then(response => response.json())
		.then(data => {
			console.log(data)
			var html = `
			<h3> ${city}, ${data.sys.country} </h3>
			<h4> ${data.main.temp} °F</h4>
			<p> Weather: ${data.weather[0].main}, ${data.weather[0].description}</p>
			<p> Humidity: ${data.main.humidity}%, Wind Spped: ${data.wind.speed} mph </p>
			<p> Min Temperature: ${data.main.temp_min} °F</p>
			<p> Max Temperature: ${data.main.temp_max} °F</p>
			`
			document.getElementById("display_info").innerHTML = html;

			let lat = data.coord.lat;
			let lon = data.coord.lon;
			// display one week forecast graph
			fetch(`https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&exclude=minutely&units=imperial&appid=a660c205d82c83622a0e4496eb8af773`)
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
				        textStyle: {
				            color: 'rgb(186, 180, 171)',
				            fontSize: 13,
				        }
				    },
				    toolbox: {
				        show: true,
				        feature: {
				            saveAsImage: {}
				        }
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
								
			// current air qualtiy value
/*			fetch(`http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat}&lon=${lon}&appid=a660c205d82c83622a0e4496eb8af773`)
			.then(response => response.json())
			.then(data => {
*/
			// previous month air quality value
			fetch(`http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=${start}&end=${end}&appid=a660c205d82c83622a0e4496eb8af773`)
			.then(response => response.json())
			.then(data => {
				let airQualityData = []
				for (let i = 0; i < data.list.length; i++){
					// get one month data
					if ((data.list[i].dt - start) % 86400 == 0){
						element = data.list[i]
						airQualityData.push([element.main.aqi, element.components.co, element.components.no2, element.components.o3, element.components.so2, element.components.pm2_5, element.components.pm10])
					}
				}
				var myChart = echarts.init(document.getElementById('main'));
				var lineStyle = {
					    normal: {
					        width: 1,
					        opacity: 0.5
					    }
					};
		
				option = {
				    backgroundColor: '#161627',
				    title: {
				        text: 'Past Month AQI',
				        textStyle: {
				            color: 'rgb(186, 180, 171)',
				            left: 20

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
			console.log(airQualityData)
			})
	    })
	    .catch(err => console.log(err))
}


// default city is irvine
if (defaultFlag){
	var city = "Irvine"
	getLocationInfo()
	defaultFlag = 0
}


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


