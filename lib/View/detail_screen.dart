import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalcase,
      totalDeaths,
      totalRecovred,
      active,
      crtical,
      todayRecoverd,
      test;
  const DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalcase,
      required this.totalDeaths,
      required this.totalRecovred,
      required this.active,
      required this.crtical,
      required this.todayRecoverd,
      required this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .067,
                ),
                child: Card(
                  elevation: 10.0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .08,
                      ),
                      ReusableRow(
                          title: 'Cases', value: widget.totalcase.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          value: widget.totalRecovred.toString()),
                      ReusableRow(
                          title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Critical', value: widget.crtical.toString()),
                      ReusableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecoverd.toString()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .017,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
