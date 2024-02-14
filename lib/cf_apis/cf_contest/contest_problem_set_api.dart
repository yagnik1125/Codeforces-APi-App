import 'dart:async';
import 'dart:convert';

import 'package:apiapp/cf_apis/cf_contest/problem_statement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CFContestProblemSetApi extends StatefulWidget {
  final dynamic contest;
  const CFContestProblemSetApi({Key? key, required this.contest})
      : super(key: key);

  @override
  State<CFContestProblemSetApi> createState() => _CFContestProblemSetApiState();
}

class _CFContestProblemSetApiState extends State<CFContestProblemSetApi> {
  List<dynamic> problems = [];
  bool isfetched = false;
  bool isLoading = true;
  // late int startTimeSeconds = 0;
  // late Timer _timer;
  late String remainingTime;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    fetchApi();
    _currentColor = Colors.amber.shade300;
    _startBlinking();
    _updateTimeRemaining();
    // Set up a periodic timer to update the time every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTimeRemaining();
    });
  }

  void _startBlinking() {
    // Set up a periodic timer to update the time and blinking color every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTimeRemaining();
      _toggleBlinkingColor();
    });
  }

  void _toggleBlinkingColor() {
    setState(() {
      _currentColor = (_currentColor == Colors.amber.shade300)
          ? Colors.white
          : Colors.amber.shade300;
    });
  }

  void _updateTimeRemaining() {
    int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int remainingTimeInSeconds =
        widget.contest['startTimeSeconds'] - currentTimeInSeconds;

    if (remainingTimeInSeconds <= 0) {
      setState(() {
        remainingTime = 'Time has already passed';
      });
    } else {
      int days = remainingTimeInSeconds ~/ 86400;
      int hours = (remainingTimeInSeconds % 86400) ~/ 3600;
      int minutes = (remainingTimeInSeconds % 3600) ~/ 60;
      int seconds = remainingTimeInSeconds % 60;

      setState(() {
        if (days == 0 && hours == 0 && minutes == 0) {
          remainingTime = '$seconds secs';
        } else if (days == 0 && hours == 0) {
          remainingTime = '$minutes mins, $seconds secs';
        } else if (days == 0) {
          remainingTime = '$hours hrs, $minutes mins, $seconds secs';
        } else {
          remainingTime ='$days days, $hours hrs, $minutes mins, $seconds secs';
        }
      });
    }
  }

  // //---------------------------------------------------------------------------------------
  // void fetchProblemStatement(String problemIndex) async {
  //   print("fetch called in pro stat");
  //   final contestId = widget.contest['id'];
  //   final url =
  //       'https://codeforces.com/contest/$contestId/problem/$problemIndex';
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final document = parse(response.body);
  //     // Extract the problem statement
  //     final problemStatement =
  //         document.querySelector('.problem-statement')?.innerHtml;
  //     print(problemStatement);
  //     print('Fetch completed in pro stat');
  //   } else {
  //     print(
  //         'Failed to fetch the problem statement. Status code: ${response.statusCode}');
  //   }
  // }
  // //---------------------------------------------------------------------------------------

  // String getTimeRemaining() {
  //   int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //   int remainingTimeInSeconds =
  //       widget.contest['startTimeSeconds'] - currentTimeInSeconds;
  //   if (remainingTimeInSeconds <= 0) {
  //     return 'Time has already passed';
  //   }
  //   int days = remainingTimeInSeconds ~/ 86400;
  //   int hours = (remainingTimeInSeconds % 86400) ~/ 3600;
  //   int minutes = (remainingTimeInSeconds % 3600) ~/ 60;
  //   int seconds = remainingTimeInSeconds % 60;
  //   // if (days > 0) {
  //   //   return "Contest starts in: $days days";
  //   // } else if (hours > 0) {
  //   //   return "Contest starts in: $hours hours";
  //   // } else if (minutes > 0) {
  //   //   return "Contest starts in: $minutes minutes";
  //   // } else if (seconds > 0) {
  //   //   return "Contest starts in: $seconds seconds";
  //   // }
  //   return '$days days, $hours hrs, $minutes mins, $seconds secs';
  // }

  void fetchApi() async {
    print("fetch called");
    final contestId = widget.contest['id'];
    // startTimeSeconds = int.parse(widget.contest['startTimeSeconds']);
    final url =
        'https://codeforces.com/api/contest.standings?contestId=$contestId&from=1&count=1&showUnofficial=false';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result);
    if (json['status'] == 'OK') {
      setState(() {
        problems = json['result']['problems'];
        isLoading = false;
        isfetched = true;
      });
      print('Fetch completed');
    } else {
      setState(() {
        isLoading = false;
      });
      print('Error fetching contest data: ${json['comment']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Codeforces Contest"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isfetched
              ? ListView.builder(
                  itemCount: problems.length,
                  itemBuilder: (context, index) {
                    final problem = problems[index];
                    final problemIndex = problem['index'];
                    final problemName = problem['name'];
                    // final tag = problem['tags'][0];
                    List<dynamic> mylist = problem['tags'];
                    String resultTags = mylist.join(', ');
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProblemStatement(
                              contestid: widget.contest['id'],
                              problemIndex: problemIndex,
                            ),
                          ),
                        );
                      },
                      // leading: Text(problemIndex),
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 145, 203, 249) // Set the color as needed
                        ),
                        child: Center(
                          child: Text(
                            problemIndex,
                          ),
                        ),
                      ),
                      title: Text(problemName),
                      subtitle: Text(resultTags),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Contest has not started yet!!😅",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Contest Starts in:",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   color: Colors.amber.shade300,
                      //   child: Center(
                      //     child: Text(
                      //       remainingTime,
                      //       // getTimeRemaining().toString(),
                      //       style: const TextStyle(
                      //         fontSize: 22,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          color: _currentColor,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                remainingTime,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
