import 'package:apiapp/cf_apis/cf_contest/cf_contest_api.dart';
import 'package:apiapp/cf_apis/cf_problemset_api.dart/problem_list_api.dart';
import 'package:apiapp/cf_apis/cf_submission_api/user_submissions_api.dart';
import 'package:apiapp/cf_apis/cf_user/cf_user_api.dart';
import 'package:apiapp/cf_apis/cf_rating/cf_user_rating_api.dart';
import 'package:apiapp/cf_apis/gym_api/gym_contest.dart';
// import 'package:apiapp/widgets/code_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'CodeForces',
              style: TextStyle(letterSpacing: 1),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CodeforcesUserApi()),
                    );
                  },
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.leaderboard_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CodeforcesUserRatingApi()),
                    );
                  },
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.code_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserSubmissionApi()),
                    );
                  },
                ),
              ),
              // ...
            ],
            bottom: const TabBar(
              indicatorWeight: 4,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: 'ProblemSet',
                ),
                Tab(
                  text: 'Contest',
                ),
                Tab(
                  text: 'Gym',
                ),
                // Tab(
                //   text: 'User',
                // ),
                // Tab(
                //   text: 'Rating',
                // ),
              ],
            ),
          ),
          body: Builder(
            builder: (context) {
              //--------------------------------------------------------------------
              // final themeMode = ref.watch(themeManagerProvider).themeMode;
              //--------------------------------------------------------------------
              return const TabBarView(
                children: [
                  // CodeforcesUserApi(),
                  ProblemListApi(),
                  CodeforcesContestApi(),
                  GymContestApi(),
                  // CodeforcesUserRatingApi(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}



//----------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Widget from HTML',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Widget from HTML'),
//         ),
//         body: Center(
//           child: HtmlWidget(
//             // the first parameter (`html`) is required
//             '''
//   <h3>Heading</h3>
//   <p>
//     A paragraph with <strong>strong</strong>, <em>emphasized</em>
//     and <span style="color: red">colored</span> text.
//   </p>
//   ''',
//           ),
//         ),
//       ),
//     );
//   }
// }
