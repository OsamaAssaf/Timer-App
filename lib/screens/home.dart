import 'package:countdown_timer/screens/count_down.dart';
import 'package:countdown_timer/screens/stopwatch.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0.0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.timelapse_outlined),
                  text: 'TIMER',
                ),
                Tab(
                  icon: Icon(Icons.timer_outlined),
                  text: 'STOPWATCH',
                ),
              ],
            ),
            shape: const Border(
              bottom: BorderSide(
                width: 2,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CountDown(),
            StopWatch(),
          ],
        ),
      ),
    );
  }
}
