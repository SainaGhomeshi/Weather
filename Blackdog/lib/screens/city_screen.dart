import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:Blackdog/API/SearchByName.dart';
import 'package:Blackdog/API/SearchByName.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    Color gradientStart;
    Color gradientEnd;
    var now = DateTime.now().hour;
    if (now >= 17) {
      gradientStart = Colors.blueAccent;
      gradientEnd = Colors.deepPurple;
    } else {
      gradientStart = Colors.yellow;
      gradientEnd = Colors.deepOrange;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a city'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientStart, gradientEnd]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                      labelText: 'City'
                  )
              ),
              suggestionsCallback: (pattern) {
                return SearchInCities.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (cityName) {
                Navigator.pop(context, cityName);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please select a city';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
