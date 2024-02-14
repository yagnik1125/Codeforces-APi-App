import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CodeforcesUserRatingApi extends StatefulWidget {
  const CodeforcesUserRatingApi({super.key});
  @override
  State<CodeforcesUserRatingApi> createState() =>
      _CodeforcesUserRatingApiState();
}

class _CodeforcesUserRatingApiState extends State<CodeforcesUserRatingApi> {
  List<dynamic> userRatedContest = [];
  bool isLoading = false;
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Contest Rating"),
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
              : userRatedContest.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: userRatedContest.length,
                        itemBuilder: (context, index) {
                          final user = userRatedContest[index];
                          final contestname = user['contestName'];
                          final int newrating = user['newRating'];
                          final int oldrating = user['oldRating'];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: newrating > oldrating
                                  ? Colors.green
                                  : Colors.grey,
                              child: Text(
                                newrating > oldrating
                                    ? "+${newrating - oldrating}"
                                    : newrating < oldrating
                                        ? "-${oldrating - newrating}"
                                        : "0",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Text(contestname),
                            subtitle: Text("Current Rating: $newrating"),
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
        'https://codeforces.com/api/user.rating?handle=${usernameController.text.toString().trim()}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result)['result'];
    List<dynamic> userRatingList = List.from(json);
    setState(() {
      userRatedContest = userRatingList.reversed.toList();
    });
    isLoading = false;
    print('Fetch completed');
  }
}
