import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  WeatherFactory wf = WeatherFactory('aa3a39927d238e1eb9c17c8b39a5683b');
  Weather? weather;
  bool isLoading = false;
  Future<void> fetchWeather(String cityName) async {
    setState(() {
      
     isLoading = true;
    });
    try {
      Weather data = await wf.currentWeatherByCityName(cityName);
      setState(() {
        weather = data;
        isLoading = false;
      });
      print(weather);
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Text('Enter a city to get weather information'),
            SizedBox(height: 25),
            SizedBox(
              width: 425,
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Search your City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      fetchWeather(controller.text);
                    },
                    icon: Icon(Icons.search),
                    label: Text(''),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            if (weather != null && !isLoading)
              Column(
                children: [
                  Text('City: ${weather!.areaName}'),
                  Text(
                      'Temperature: ${weather!.temperature!.celsius!.toStringAsFixed(1)}°C'),
                  Text('Weather: ${weather!.weatherDescription}')
                ],
              ),
              if(isLoading == true)
                Text('Loading data............',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              if(isLoading == false)
                if (weather == null)
                Text(
                  'No data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }
}
