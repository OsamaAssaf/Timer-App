import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Stopwatch stopwatch = Stopwatch();

  Timer? timer;

  IconData icon = Icons.play_arrow;

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String time = stopwatch.elapsed
        .toString()
        .replaceRange(0, 2, '')
        .replaceRange(7, 11, '');
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                if (stopwatch.isRunning) {
                  stopwatch.stop();
                  timer!.cancel();
                  setState(() {
                    icon = Icons.play_arrow;
                  });
                } else {
                  stopwatch.start();
                  timer =
                      Timer.periodic(const Duration(milliseconds: 30), (timer) {
                    setState(() {
                      time = stopwatch.elapsed.toString();
                    });
                  });
                  setState(() {
                    icon = Icons.pause;
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.grey,
                ),
                radius: 30.0,
              ),
            ),
            bottom: 32.0,
          ),
          Positioned(
            child: TextButton(
              child: Text(
                "RESET",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                stopwatch.stop();
                stopwatch.reset();
                timer!.cancel();

                setState(() {
                  time = stopwatch.elapsed.toString();
                });
              },
            ),
            left: 32.0,
            bottom: 32.0,
          ),
        ],
      ),
    );
  }
}
