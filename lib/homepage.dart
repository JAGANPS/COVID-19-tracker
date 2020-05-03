import 'dart:convert';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:covidstatewise/datasorce.dart';
import 'package:covidstatewise/pages/countyPage.dart';
import 'package:covidstatewise/panels/infoPanel.dart';
import 'package:covidstatewise/panels/mosteffectedcountries.dart';
import 'package:covidstatewise/panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;
//import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries/india');
    setState(() {
      worldData = json.decode(response.body);
    });
  }
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchdata() async{
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    //fetchWorldWideData();
    //fetchCountryData();
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],
        title: Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchdata ,
              child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'ALL OVER INDIA',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CountryPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Most affected Countries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(
                    countryData: countryData,
                  ),
            InfoPanel(),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
            ' LETS  FIGHT TOGETHER AGAINST CORONAVIRUS ❤️❤️❤️❤️❤️❤️🤝🤝🤝🤝🤝🤝💪🧑‍👨‍⚕️🧑‍👨‍🎓👩‍🎓🧑‍🏫👨‍🏫🧑‍⚖️👩‍⚖️👨‍🌾🧑‍👨‍🍳🧑‍🔧👩‍🔧👮👮‍♀️',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
            SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }
}
