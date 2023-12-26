import 'package:covid_tracker/Services/state_services.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
              future: stateService.fetchWorldStateRecord(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        chartType: ChartType.ring,
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(
                              snapshot.data!.recovered!.toString()),
                          "Death":
                              double.parse(snapshot.data!.deaths!.toString())
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: const Duration(seconds: 3),
                        legendOptions: const LegendOptions(
                            showLegends: true,
                            legendPosition: LegendPosition.left),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .02),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!.toString()),
                              ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString()),
                              ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString()),
                              ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString()),
                              ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical!.toString()),
                              ReusableRow(
                                  title: 'Today Deaths',
                                  value:
                                      snapshot.data!.todayDeaths!.toString()),
                              ReusableRow(
                                  title: 'Total Recoverd',
                                  value: snapshot.data!.todayRecovered!
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CountriesList(),
                            )),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "Track Countries",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
