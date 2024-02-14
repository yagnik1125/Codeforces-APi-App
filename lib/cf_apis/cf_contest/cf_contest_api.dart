// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class CodeforcesContestApi extends StatefulWidget {
//   const CodeforcesContestApi({super.key});
//   @override
//   State<CodeforcesContestApi> createState() => _CodeforcesContestApiState();
//
// class _CodeforcesContestApiState extends State<CodeforcesContestApi> {
//   List<dynamic> contests = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Codeforces contest Api Demo"),
//       ),
//       body: ListView.builder(
//         itemCount: contests.length,
//         itemBuilder: (context, index) {
//           final contest = contests[index];
//           final contestname = contest['name'];
//           final div = contest['difficulty'];
//           return ListTile(
//             leading: Text("$index"),
//             title: Text(contestname),
//             subtitle: Text("Div $div"),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchapi,
//         child: const Text("Fetch"),
//       ),
//     );
//   }
//   void fetchapi() async {
//     print("fetch called");
//     const url = 'https://codeforces.com/api/contestname.list?gym=false';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final result = response.body;
//     final json = jsonDecode(result);
//     setState(() {
//       contests = json['result'];
//     });
//     print('Fetch completed');
//   }
// }

//----------------------------------------------------------------------------------------------------------
import 'dart:convert';

import 'package:apiapp/cf_apis/cf_contest/contest_problem_set_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CodeforcesContestApi extends StatefulWidget {
  const CodeforcesContestApi({Key? key}) : super(key: key);

  @override
  State<CodeforcesContestApi> createState() => _CodeforcesContestApiState();
}

class _CodeforcesContestApiState extends State<CodeforcesContestApi> {
  List<dynamic> contests = [];
  List<dynamic> upcomingContests = [];
  List<dynamic> completedContests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  void fetchApi() async {
    print("fetch called");
    const url = 'https://codeforces.com/api/contest.list?gym=false';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result);
    if (json['status'] == 'OK') {
      setState(() {
        contests = json['result'];
        for (var contest in contests) {
          if (contest['relativeTimeSeconds'] < 0) {
            upcomingContests.add(contest);
          } else {
            completedContests.add(contest);
          }
        }
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
        title: const Text("Codeforces Contest"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: upcomingContests.isNotEmpty
                          ? const Text(
                              "Upcoming Contests",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upcomingContests.length,
                    itemBuilder: (context, index) {
                      final contest = upcomingContests[index];
                      final id = contest['id'];
                      final contestname = contest['name'];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CFContestProblemSetApi(
                                contest: contest,
                              ),
                            ),
                          );
                        },
                        leading: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 145, 203, 249)
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Past Contests",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completedContests.length,
                    itemBuilder: (context, index) {
                      final contest = completedContests[index];
                      final id = contest['id'];
                      final contestname = contest['name'];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CFContestProblemSetApi(
                                contest: contest,
                              ),
                            ),
                          );
                        },
                        leading: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 105, 182, 244),
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
                ],
              ),
            ),
    );
  }
}




// Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "title",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: upcomingContests.length,
//                   itemBuilder: (context, index) {
//                     final contest = upcomingContests[index];
//                     final id = contest['id'];
//                     final contestname = contest['name'];
//                     return ListTile(
//                       onTap: () {
//                         Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CFContestProblemSetApi(
//                             contest: contest,
//                           ),
//                         ),
//                       );
//                       },
//                       leading: Container(
//                         width: 45,
//                         height: 45,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color.fromARGB(255, 105, 182, 244),
//                         ),
//                         child: Center(
//                           child: Text(
//                             id.toString(),
//                           ),
//                         ),
//                       ),
//                       title: Text(contestname),
//                     );
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
// }
