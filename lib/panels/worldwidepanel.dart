import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  //get worldData1 => null;
  //const WorldwidePanel1({Key key, this.worldData1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldData['deaths'].toString(),
          ),
          StatusPanel(
            title: 'TODAY CASES',
            panelColor: Colors.amberAccent,
            textColor: Colors.blueAccent,
            count: worldData['todayCases'].toString(),
          ),
          StatusPanel(
            title: 'TODAY DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldData['todayDeaths'].toString(),
          ),
          StatusPanel(
            title: 'TEST CONDUCTED\n\t\t\t\t\t\t\t\tDAILY ',
            panelColor: Colors.green[400],
            textColor: Colors.green[900],
            count: worldData['tests'].toString(),
          ),
          StatusPanel(
            title: 'CASES PER 1 MILLION',
            panelColor: Colors.orangeAccent,
            textColor: Colors.tealAccent[900],
            count: worldData['casesPerOneMillion'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS PER 1MILLION',
            panelColor: Colors.yellow,
            textColor: Colors.yellow[900],
            count: worldData['deathsPerOneMillion'].toString(),
          ),
          StatusPanel(
            title: 'TEST PER 1 MILLION',
            panelColor: Colors.deepPurple,
            textColor: Colors.lightGreen,
            count: worldData['testsPerOneMillion'].toString(),
          ),
          
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
