import 'dart:convert';

import 'package:apiapp/cf_apis/gym_api/gym_problem_statement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GymContestProblemSetApi extends StatefulWidget {
  final dynamic contest;
  const GymContestProblemSetApi({Key? key, required this.contest})
      : super(key: key);

  @override
  State<GymContestProblemSetApi> createState() => _GymContestProblemSetApiState();
}

class _GymContestProblemSetApiState extends State<GymContestProblemSetApi> {
  List<dynamic> problems = [];
  bool isfetched = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

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
        title: const Text("Contest"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: problems.length,
              itemBuilder: (context, index) {
                final problem = problems[index];
                final problemIndex = problem['index'];
                final problemName = problem['name'];
                // final tag = problem['tags'][0];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymProblemStatement(
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
                  // subtitle: Text(tag),
                );
              },
            ),
    );
  }
}
