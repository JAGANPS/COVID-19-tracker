import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covidstatewise/pages/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){

            showSearch(context: context, delegate: Search(countryData));

          },)
        ],
        title: Text('COUNTRY STATUS'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 180,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                countryData[index]['country'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 130,
                                width: 170,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'CONFIRMED:' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVE:' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'CRTICAL:' +
                                    countryData[index]['critical'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.indigo[100]:Colors.indigo[900]),
                              ),
                              Text(
                                'RECOVERED:' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DEATHS:' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              Text(
                                'TESTS:' +
                                    countryData[index]['tests'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              Text(
                                'TODAY CASES:' +
                                    countryData[index]['todayCases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              Text(
                                'TODAY DEATHS:' +
                                    countryData[index]['todayDeaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              Text(
                                'CONTINENTS:' +
                                    countryData[index]['continent'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              

                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}