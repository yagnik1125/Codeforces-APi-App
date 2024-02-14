import 'dart:convert';

import 'package:apiapp/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CodeforcesUserApi extends StatefulWidget {
  const CodeforcesUserApi({super.key});
  @override
  State<CodeforcesUserApi> createState() => _CodeforcesUserApiState();
}

class _CodeforcesUserApiState extends State<CodeforcesUserApi> {
  List<dynamic> users = [];
  List<dynamic> reverseusers = [];
  bool isLoading = false;
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
        title: const Text("Codeforces User"),
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
              : users.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            // leading: ClipRect(
                            //   child: Image.network(user['titlePhoto']),
                            // ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UserCard(user: user);
                                },
                              );
                            },
                            leading: SizedBox(
                              width: 75,
                              height: 75,
                              child: Image.network(
                                user['titlePhoto'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text("Handle: ${user['handle']}"),
                            subtitle: Text("Rating: ${user['rating']}"),
                            trailing: Text(
                              "${user['rank']}",
                              style: TextStyle(
                                color: userColorMap[user['rank']],
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

  // void fetchapi() async {
  //   print("fetch called");
  //   String url =
  //       'https://codeforces.com/api/user.info?handles=${usernameController.text.toString()}';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final result = response.body;
  //   final json = jsonDecode(result);
  //   setState(() {
  //     // users = json['result'];
  //     users.add(json['result']);
  //   });
  //   print('Fetch completed');
  // }
  void fetchapi() async {
    setState(() {
      isLoading = true;
    });
    print("fetch called");
    String url =
        'https://codeforces.com/api/user.info?handles=${usernameController.text.toString().trim()}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result);
    setState(() {
      if (json['status'] == 'OK') {
        // Check if the status is OK before accessing the result
        // users.addAll(
        //     json['result']); // Clear the existing users and add the new ones
        // users = json['result'];
        reverseusers.addAll(json['result']);
        users = reverseusers.reversed.toList();
      } else {
        users = []; // Clear the list in case of an error
      }
    });
    isLoading = false;
    print('Fetch completed');
  }
}
