import 'dart:async';

import 'package:countdown_timer/services/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:audioplayers/audioplayers.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with WidgetsBindingObserver {
  int? seconds1;
  int? seconds2;
  int? minutes1;
  int? minutes2;
  int? hour1;
  int? hour2;

  int totalSeconds = 0;

  bool isStopped = true;

  Timer? timer;

  DateTime? datetime;

  List<int> inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  IconData timerIcon = Icons.pause;

  bool percentIndicator = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    NotificationApi.init();
    listenNotifications();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        NotificationApi.cancelAllNotification();
        break;
      case AppLifecycleState.inactive:
        NotificationApi.showScheduledNotification(
          title: 'Timer end',
          body: 'ok?',
          payload: 'osama',
          scheduledDate: DateTime.now().add(Duration(seconds: totalSeconds)),
        );
        break;
      case AppLifecycleState.paused:
        NotificationApi.showScheduledNotification(
          title: 'Timer end',
          body: 'ok?',
          payload: 'osama',
          scheduledDate: DateTime.now().add(Duration(seconds: totalSeconds)),
        );
        break;
      case AppLifecycleState.detached:
        NotificationApi.showScheduledNotification(
          title: 'Timer end',
          body: 'ok?',
          payload: 'osama',
          scheduledDate: DateTime.now().add(Duration(seconds: totalSeconds)),
        );
        break;
    }
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const CountDown()));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            isStopped
                ? SizedBox(
                    width: 333,
                    height: 90,
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 64, color: Colors.grey),
                      child: Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            hour1 == null
                                ? '00'
                                : hour2 == null
                                    ? "0$hour1"
                                    : "$hour2$hour1",
                          ),
                          const Text(
                            'h',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            minutes1 == null
                                ? "00"
                                : minutes2 == null
                                    ? "0$minutes1"
                                    : "$minutes2$minutes1",
                          ),
                          const Text(
                            'm',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            seconds1 == null
                                ? "00"
                                : seconds2 == null
                                    ? "0$seconds1"
                                    : "$seconds2$seconds1",
                          ),
                          const Text(
                            's',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onLongPress: () {
                              setState(() {
                                seconds1 = null;
                                seconds2 = null;
                                minutes1 = null;
                                minutes2 = null;
                                hour1 = null;
                                hour2 = null;
                              });
                            },
                            onTap: () {
                              setState(() {
                                if (hour2 != null) {
                                  seconds1 = seconds2;
                                  seconds2 = minutes1;
                                  minutes1 = minutes2;
                                  minutes2 = hour1;
                                  hour1 = hour2;
                                  hour2 = null;
                                } else {
                                  if (hour1 != null) {
                                    seconds1 = seconds2;
                                    seconds2 = minutes1;
                                    minutes1 = minutes2;
                                    minutes2 = hour1;
                                    hour1 = null;
                                  } else {
                                    if (minutes2 != null) {
                                      seconds1 = seconds2;
                                      seconds2 = minutes1;
                                      minutes1 = minutes2;
                                      minutes2 = null;
                                    } else {
                                      if (minutes1 != null) {
                                        seconds1 = seconds2;
                                        seconds2 = minutes1;
                                        minutes1 = null;
                                      } else {
                                        if (seconds2 != null) {
                                          seconds1 = seconds2;
                                          seconds2 = null;
                                        } else {
                                          seconds1 = null;
                                        }
                                      }
                                    }
                                  }
                                }
                              });
                            },
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : percentIndicator
                    ? CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.5,
                        lineWidth: 10.0,
                        animation: true,
                        animationDuration: totalSeconds * 1000,
                        percent: 1.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        reverse: true,
                        center: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: FittedBox(
                            child: Text(
                              datetime!.day - 1 == 0
                                  ? DateFormat('HH:mm:ss').format(datetime!)
                                  : "${datetime!.day - 1} day ${DateFormat('HH:mm:ss').format(datetime!)}",
                              style: const TextStyle(
                                fontSize: 64,
                              ),
                            ),
                          ),
                        ),
                        progressColor: Theme.of(context).primaryColor,
                        curve: Curves.linear,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: FittedBox(
                          child: Text(
                            datetime!.day - 1 == 0
                                ? DateFormat('HH:mm:ss').format(datetime!)
                                : "${datetime!.day - 1} day ${DateFormat('HH:mm:ss').format(datetime!)}",
                            style: const TextStyle(
                              fontSize: 64,
                            ),
                          ),
                        ),
                      ),
            if (isStopped)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.57,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        childAspectRatio: 1.0,
                        children: List.generate(
                          9,
                          (index) => inputNumber(index),
                        ),
                      ),
                    ),
                    inputNumber(0, grid: false),
                  ],
                ),
              ),
            if (isStopped && seconds1 != null)
              InkWell(
                onTap: () {
                  if (seconds2 == null) {
                    setState(() {
                      seconds2 = 0;
                      minutes1 = 0;
                      minutes2 = 0;
                      hour1 = 0;
                      hour2 = 0;
                    });
                  } else {
                    if (minutes1 == null) {
                      setState(() {
                        minutes1 = 0;
                        minutes2 = 0;
                        hour1 = 0;
                        hour2 = 0;
                      });
                    } else {
                      if (minutes2 == null) {
                        setState(() {
                          minutes2 = 0;
                          hour1 = 0;
                          hour2 = 0;
                        });
                      } else {
                        if (hour1 == null) {
                          setState(() {
                            hour1 = 0;
                            hour2 = 0;
                          });
                        } else {
                          if (hour2 == null) {
                            setState(() {
                              hour2 = 0;
                            });
                          }
                        }
                      }
                    }
                  }
                  setState(() {
                    isStopped = false;
                  });

                  int seconds = int.parse("$seconds2$seconds1");
                  int minutes = int.parse("$minutes2$minutes1");
                  int hours = int.parse("$hour2$hour1");

                  if (seconds > 59) {
                    minutes = minutes + ((seconds / 60).floor());
                    seconds = seconds - ((seconds / 60).floor() * 60);
                  }
                  if (minutes > 59) {
                    hours = hours + ((minutes / 60).floor());
                    minutes = minutes - ((minutes / 60).floor() * 60);
                  }

                  datetime = DateFormat.Hms().parse("$hours:$minutes:$seconds");

                  totalSeconds = datetime!.second +
                      (datetime!.minute * 60) +
                      (datetime!.hour * 3600) +
                      ((datetime!.day - 1) * 86400);

                  timer = startTimer();
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.play_arrow,
                    size: 30,
                  ),
                  radius: 30,
                ),
              )
            else
              Container(
                height: 60,
              ),
            if (!isStopped)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (timer!.isActive) {
                        timer!.cancel();
                        setState(() {
                          timerIcon = Icons.play_arrow;
                          percentIndicator = false;
                        });
                      } else {
                        setState(() {
                          timerIcon = Icons.pause;
                          percentIndicator = true;
                        });
                        timer = startTimer();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        timerIcon,
                        size: 30,
                      ),
                      radius: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isStopped = true;
                      });
                      timer!.cancel();
                      resetTimer();
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.stop,
                        size: 30,
                      ),
                      radius: 30,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Timer startTimer() {
    return Timer.periodic(const Duration(seconds: 1), (timer) {
      totalSeconds--;
      if (totalSeconds < 0) {
        final AudioCache player = AudioCache();
        player.play('timer_end.mp3');
        timer.cancel();
        resetTimer();
        return;
      }
      setState(() {
        datetime = datetime!.subtract(const Duration(seconds: 1));
      });
    });
  }

  void resetTimer() {
    seconds1 = null;
    seconds2 = null;
    minutes1 = null;
    minutes2 = null;
    hour1 = null;
    hour2 = null;
    setState(() {
      isStopped = true;
    });
  }

  InkWell inputNumber(int index, {bool grid = true}) {
    if (!grid) {
      index = 0;
    } else {
      index = index + 1;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(60.0),
      onTap: () {
        if (seconds1 == null && index == 0) {
          return;
        }
        if (seconds1 == null) {
          setState(() {
            seconds1 = index;
          });
        } else {
          if (seconds2 == null) {
            setState(() {
              seconds2 = seconds1;
              seconds1 = index;
            });
          } else {
            if (minutes1 == null) {
              setState(() {
                minutes1 = seconds2;
                seconds2 = seconds1;
                seconds1 = index;
              });
            } else {
              if (minutes2 == null) {
                setState(() {
                  minutes2 = minutes1;
                  minutes1 = seconds2;
                  seconds2 = seconds1;
                  seconds1 = index;
                });
              } else {
                if (hour1 == null) {
                  setState(() {
                    hour1 = minutes2;
                    minutes2 = minutes1;
                    minutes1 = seconds2;
                    seconds2 = seconds1;
                    seconds1 = index;
                  });
                } else {
                  if (hour2 == null) {
                    setState(() {
                      hour2 = hour1;
                      hour1 = minutes2;
                      minutes2 = minutes1;
                      minutes1 = seconds2;
                      seconds2 = seconds1;
                      seconds1 = index;
                    });
                  }
                }
              }
            }
          }
        }
      },
      child: SizedBox(
        width: 115,
        height: 115,
        child: Center(
          child: Text(
            index.toString(),
            style: const TextStyle(color: Colors.grey, fontSize: 64),
          ),
        ),
      ),
    );
  }
}
