import 'dart:convert';

import 'package:apiapp/cf_apis/cf_problemset_api.dart/problemset_problem_statement.dart';
import 'package:apiapp/widgets/tag_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProblemListApi extends StatefulWidget {
  const ProblemListApi({super.key});

  @override
  State<ProblemListApi> createState() => _ProblemListApiState();
}

class _ProblemListApiState extends State<ProblemListApi> {
  List<dynamic> problems = [];
  List<dynamic> problemStatistics = [];
  bool isLoading = true;
  final TextEditingController tagController = TextEditingController();
  String selectedTag = ''; // Track the selected tag
  // List<String> availableTags = ['tag1', 'tag2', 'tag3']; // Replace with your actual tags

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProblemSet"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          // TextField(
          //   controller: tagController,
          //   decoration: const InputDecoration(
          //     labelText: 'tag',
          //     hintText: 'Select Tag',
          //     prefixIcon: Icon(Icons.tag),
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          // // DropdownButton<String>(
          // //   value: selectedTag,
          // //   onChanged: (String? newValue) {
          // //     setState(() {
          // //       selectedTag = newValue!;
          // //     });
          // //   },
          // //   items: availableTags.map<DropdownMenuItem<String>>((String value) {
          // //     return DropdownMenuItem<String>(
          // //       value: value,
          // //       child: Text(value),
          // //     );
          // //   }).toList(),
          // //   hint: const Text('Select Tag'),
          // // ),
          // //---
          Row(
            children: [
              TagBox(
                tag: selectedTag,
                onTagChanged: (value) {
                  setState(() {
                    selectedTag = value;
                    // print(value);
                    fetchapi();
                  });
                },
              ),
            ],
          ),

          const ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  "Index",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              "Problem with Tags",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              "Solved By",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //---
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: problems.length,
                    itemBuilder: (context, index) {
                      final problem = problems[index];
                      final id = problem['contestId'].toString();
                      final idx = problem['index'].toString();
                      final ididx = id + idx;
                      final name = problem['name'];
                      final solvedCount =
                          problemStatistics[index]['solvedCount'].toString();
                      List<dynamic> mylist = problem['tags'];
                      String resultTags = mylist.join(', ');
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProblemsetProblemStatement(
                                contestid: id,
                                problemIndex: idx,
                              ),
                            ),
                          );
                        },
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 145, 203, 249)),
                          child: Center(
                            child: Text(
                              ididx.toString(),
                            ),
                          ),
                        ),
                        title: Text(name),
                        subtitle: Text(resultTags),
                        trailing: Text(
                          solvedCount,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // fontSize: 18,
                      );
                    },
                  ),
                ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchapi,
      //   child: const Text("Fetch"),
      // ),
    );
  }

  void fetchapi() async {
    isLoading = true;
    // print(selectedTag);
    setState(() {});
    print("fetch called");
    // const url = 'https://codeforces.com/api/problemset.problems?';
    String url = '';
    if (selectedTag == "") {
      url = 'https://codeforces.com/api/problemset.problems?';
    } else {
      url = 'https://codeforces.com/api/problemset.problems?tags=$selectedTag';
    }
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final result = response.body;
    final json = jsonDecode(result);
    setState(() {
      problems = json['result']['problems'];
      problemStatistics = json['result']['problemStatistics'];
    });
    isLoading = false;
    print('Fetch completed');
  }
}
