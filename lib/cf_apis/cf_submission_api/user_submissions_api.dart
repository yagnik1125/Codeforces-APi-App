import 'dart:convert';

import 'package:apiapp/widgets/submission_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserSubmissionApi extends StatefulWidget {
  const UserSubmissionApi({super.key});
  @override
  State<UserSubmissionApi> createState() => _UserSubmissionApiState();
}

class _UserSubmissionApiState extends State<UserSubmissionApi> {
  List<dynamic> userSubmissions = [];
  List<dynamic> author = [];
  bool isLoading = false;
  // List<dynamic> reverseusers = [];
  Map<String, Color> userColorMap = {
    'unrated': Colors.grey,
    'pupil': Colors.green,
    'pupil+': Colors.green,
    'specialist': Colors.cyan,
    'specialist+': Colors.cyan,
    'expert': const Color.fromARGB(255, 33, 89, 243),
    'expert+': const Color.fromARGB(255, 33, 89, 243),
    'candidate master': Colors.purple,
    'candidate master+': Colors.purple,
    'master': Colors.yellow,
    'international master': Colors.orange,
    'grandmaster': Colors.red,
    'international grandmaster': Colors.red,
    'legendary grandmaster': const Color.fromARGB(255, 239, 37, 23),
  };
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Codeforces User Submission"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : userSubmissions.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: userSubmissions.length,
                        itemBuilder: (context, index) {
                          final submission = userSubmissions[index];
                          return ListTile(
                            // leading: ClipRect(
                            //   child: Image.network(user['titlePhoto']),
                            // ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SubmissionCard(
                                    submission: submission,
                                  );
                                },
                              );
                            },
                            leading: Container(
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                shape: BoxShape.rectangle,
                                color: const Color.fromARGB(255, 145, 203, 249),
                              ),
                              child: Center(
                                child: Text(
                                  submission['id'].toString(),
                                ),
                              ),
                            ),
                            // title: Expanded(
                            //   child: Text(
                            //       "${submission['problem']['index']} - ${submission['problem']['name']}"),
                            // ),
                            // subtitle: Expanded(
                            //   child: Text(
                            //       "Author : ${submission['author']['members'][0]['handle']}"),
                            // ),
                            // trailing: submission['verdict'] == "OK"
                            //     ? const Expanded(
                            //         child: Text(
                            //           "ACCEPTED",
                            //           style: TextStyle(color: Colors.green),
                            //         ),
                            //       )
                            //     : Expanded(
                            //         child: Text(
                            //           "${submission['verdict']}",
                            //           style: const TextStyle(color: Colors.red),
                            //         ),
                            //       ),
                            title: Text(
                                "${submission['problem']['index']} - ${submission['problem']['name']}"),
                            subtitle: Row(
                              children: [
                                const Text('Author: '),
                                Text(
                                  "${submission['author']['members'][0]['handle']}",
                                  style: TextStyle(
                                    color: author.isNotEmpty
                                        ? userColorMap[author[0]['rank']]
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Adjust the trailing widget to ensure it fits within the ListTile
                            trailing: SizedBox(
                              width: 80, // Adjust width as needed
                              child: submission['verdict'] == "OK"
                                  ? const Text(
                                      "ACCEPTED",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      "${submission['verdict']}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchapi,
        child: const Text("Fetch"),
      ),
    );
  }

  void fetchapi() async {
    setState(() {
      isLoading = true;
    });
    print("fetch called");
    String url =
        "https://codeforces.com/api/user.status?handle=${usernameController.text.toString().trim()}&from=1";
    // 'https://codeforces.com/api/user.info?handles=${usernameController.text.toString().trim()}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result);
    setState(() {
      if (json['status'] == 'OK') {
        userSubmissions = json['result'];
      } else {
        userSubmissions = []; // Clear the list in case of an error
      }
    });

    String urlAuthor =
        "https://codeforces.com/api/user.info?handles=${usernameController.text.toString().trim()}";
    // 'https://codeforces.com/api/user.info?handles=${usernameController.text.toString().trim()}';
    final uriAuthor = Uri.parse(urlAuthor);
    final responseAuthor = await http.get(uriAuthor);
    final resultAuthor = responseAuthor.body;
    final jsonAuthor = jsonDecode(resultAuthor);
    setState(() {
      if (jsonAuthor['status'] == 'OK') {
        author = jsonAuthor['result'];
      } else {
        author = jsonAuthor['status'];
      }
    });
    isLoading = false;
    print('Fetch completed');
  }
}
