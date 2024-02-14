import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final dynamic user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
    String getTimeDifferenceFromNow(int timestampInSeconds) {
      DateTime now = DateTime.now();
      DateTime timestamp =
          DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

      Duration difference = now.difference(timestamp);

      if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    }

    String capitalizeFirstLetter(String input) {
      if (input.isEmpty) {
        return input;
      }
      return input[0].toUpperCase() + input.substring(1);
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: const Color.fromARGB(0, 242, 235, 235),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User Profile Picture
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(user['titlePhoto']),
            ),

            const SizedBox(height: 16.0),

            // // User Name
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       capitalizeFirstLetter(user['rank'].toString()),
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         color: userColorMap[user['rank']],
            //       ),
            //     ),
            //     // Text(
            //     //   "${user['handle']}",
            //     //   style: TextStyle(
            //     //     fontSize: 18.0,
            //     //     fontWeight: FontWeight.bold,
            //     //     color: userColorMap[user['maxRank']],
            //     //   ),
            //     // ),
            //     user['rank'] == 'legendary grandmaster'
            //         ? Text(
            //             " : ${user['handle'][0]}",
            //             style: const TextStyle(
            //               fontSize: 18.0,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           )
            //         : Container(), // Empty container for non-'legendary grandmaster' users
            //     Text(
            //       user['rank'] == 'legendary grandmaster'
            //           ? "${user['handle'].substring(1)}"
            //           : " : ${user['handle']}",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         color: userColorMap[user['rank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Text(
            //   "${user['firstName']} ${user['lastName']}",
            //   style: const TextStyle(
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.bold,
            //     // color: userColorMap[user['maxRank']],
            //   ),
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Current rating : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       " ${user['rating']}",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         color: userColorMap[user['rank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Max rating : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       " ${user['maxRating']}",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Max Rank : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       capitalizeFirstLetter(user['maxRank'].toString()),
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Contribution : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       " ${user['contribution']}",
            //       style: const TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       " Friend of : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       " ${user['friendOfCount']}",
            //       style: const TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       " Last seen : ",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //     Text(
            //       getTimeDifferenceFromNow(user['lastOnlineTimeSeconds'])
            //           .toString(),
            //       style: const TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.bold,
            //         // color: userColorMap[user['maxRank']],
            //       ),
            //     ),
            //   ],
            // ),
            //---------------------------------------------------------------------

//-------------------------------------------------------------------------------------
            Text(
              "${user['firstName']} ${user['lastName']}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            user['rank'] == 'legendary grandmaster'
                ? _buildLagendaryGrandmaster(
                    userColorMap, capitalizeFirstLetter)
                : _buildRowWithColoredContainers(
                    capitalizeFirstLetter(user['rank'].toString()),
                    "${user['handle']}",
                    TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: userColorMap[user['rank']],
                    ),
                    TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: userColorMap[user['rank']],
                    ),
                  ),

            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Current rating",
              "${user['rating']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Max rating",
              "${user['maxRating']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Max Rank",
              capitalizeFirstLetter(user['maxRank'].toString()),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Contribution",
              "${user['contribution']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Friend of",
              "${user['friendOfCount']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Last seen",
              getTimeDifferenceFromNow(user['lastOnlineTimeSeconds'])
                  .toString(),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                // color: userColorMap[user['maxRank']],
              ),
            ),

            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: userColorMap[user['maxRank']],
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //   ),
            //   onPressed: () {
            //     print(DateTime.fromMillisecondsSinceEpoch(1707490094 * 1000)
            //         .toString());
            //   },
            //   child: const Text(
            //     "Visit",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),

            // Other User Details
            // Add other details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithColoredContainers(dynamic textLeft, dynamic textRight,
      TextStyle leftStyle, TextStyle rightStyle) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                textLeft,
                style: leftStyle,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          ":-",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                textRight,
                style: rightStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLagendaryGrandmaster(
      Map<String, Color> userColorMap, Function(String) capitalizeFirstLetter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            capitalizeFirstLetter(user['rank'].toString()),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: userColorMap[user['rank']],
            ),
          ),
        ),
        const Text(":-",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${user['handle'][0]}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "${user['handle'].substring(1)}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: userColorMap[user['rank']],
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // return Text("");
  }
}



// Text(
//   " : ${user['handle'][0]}",
//   style: const TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//   ),
// ),
// Text(
//   "${user['handle'].substring(1)}",
//   style: TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold,
//     color: userColorMap[user['maxRank']],
//   ),
// ),

//sampleinput---------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' show parse;
// class Input extends StatelessWidget {
//   final String htmlData =
//       '<div class="title">Input</div><pre><div class="test-example-line test-example-line-even test-example-line-0">5</div><div class="test-example-line test-example-line-odd test-example-line-1">2 2</div><div class="test-example-line test-example-line-even test-example-line-2">7 8</div><div class="test-example-line test-example-line-odd test-example-line-3">16 9</div><div class="test-example-line test-example-line-even test-example-line-4">3 5</div><div class="test-example-line test-example-line-odd test-example-line-5">10000 10000</div></pre>';
//   @override
//   Widget build(BuildContext context) {
//     String extractedData = extractDataFromHtml(htmlData);
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text(extractedData),
//         ),
//       ),
//     );
//   }
//   String extractDataFromHtml(String htmlString) {
//     final document = parse(htmlString);
//     final preElement = document.querySelector('pre');
//     if (preElement != null) {
//       String preText = preElement.text.trim();
//       return extractLines(preText);
//     } else {
//       return 'Data not found';
//     }
//   }
//   String extractLines(String text) {
//     RegExp regex = RegExp(r'\b\d+(\s+\d+)*\b');
//     Iterable<RegExpMatch> matches = regex.allMatches(text);
//     List<String> lines = matches.map((match) => match.group(0)!).toList();
//     return lines.join('\n');
//   }
// }

//sampleoutput----------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' show parse;
// class Output extends StatelessWidget {
//   final String htmlData =
//       '<div class="title">Output</div><pre>2\n28\n64\n6\n50000000\n</pre>';
//   @override
//   Widget build(BuildContext context) {
//     String extractedData = extractDataFromHtml(htmlData);
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text(extractedData),
//         ),
//       ),
//     );
//   }
//   String extractDataFromHtml(String htmlString) {
//     final document = parse(htmlString);
//     final preElement = document.querySelector('pre');
//     if (preElement != null) {
//       String preText = preElement.text.trim();
//       return extractLines(preText);
//     } else {
//       return 'Data not found';
//     }
//   }
//   String extractLines(String text) {
//     return text.trim();
//   }
// }
