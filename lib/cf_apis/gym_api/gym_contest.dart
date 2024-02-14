import 'dart:convert';

import 'package:apiapp/cf_apis/gym_api/gym_problem_set_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GymContestApi extends StatefulWidget {
  const GymContestApi({Key? key}) : super(key: key);

  @override
  State<GymContestApi> createState() => _GymContestApiState();
}

class _GymContestApiState extends State<GymContestApi> {
  List<dynamic> contests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  void fetchApi() async {
    print("fetch called");
    const url = 'https://codeforces.com/api/contest.list?gym=true';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print("done");
    final result = response.body;
    final json = jsonDecode(result);
    if (json['status'] == 'OK') {
      setState(() {
        contests = json['result'];
        isLoading = false;
      });
      print('Fetch completed');
    } else {
      print('Error fetching contest data: ${json['comment']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gym Contest"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contests.length,
                itemBuilder: (context, index) {
                  final contest = contests[index];
                  final id = contest['id'];
                  final contestname = contest['name'];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GymContestProblemSetApi(
                            contest: contest,
                          ),
                        ),
                      );
                    },
                    leading: Container(
                      width: 70,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        shape: BoxShape.rectangle,
                        color: const Color.fromARGB(255, 145, 203, 249)
                      ),
                      child: Center(
                        child: Text(
                          id.toString(),
                        ),
                      ),
                    ),
                    title: Text(contestname),
                  );
                },
              ),
            ),
    );
  }
}
