import 'package:flutter/material.dart';
import 'package:flutter_covid_tracking_app/view/world_stats.dart';

class DetailScreen extends StatefulWidget {

  String name,image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayDeaths, todayRecovered, test;

  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name.toUpperCase()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [

                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Active', value: widget.active.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(title: 'Tests', value: widget.test.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'Today Deaths', value: widget.todayDeaths.toString()),

                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
