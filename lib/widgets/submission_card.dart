import 'package:flutter/material.dart';

class SubmissionCard extends StatelessWidget {
  final dynamic submission;

  const SubmissionCard({super.key, required this.submission});

  @override
  Widget build(BuildContext context) {
    // Map<String, Color> userColorMap = {
    //   'unrated': Colors.grey,
    //   'pupil': Colors.green,
    //   'pupil+': Colors.green,
    //   'specialist': Colors.cyan,
    //   'specialist+': Colors.cyan,
    //   'expert': const Color.fromARGB(255, 33, 89, 243),
    //   'expert+': const Color.fromARGB(255, 33, 89, 243),
    //   'candidate master': Colors.purple,
    //   'candidate master+': Colors.purple,
    //   'master': Colors.yellow,
    //   'international master': Colors.orange,
    //   'grandmaster': Colors.red,
    //   'international grandmaster': Colors.red,
    //   'legendary grandmaster': const Color.fromARGB(255, 239, 37, 23),
    // };
    // String getTimeDifferenceFromNow(int timestampInSeconds) {
    //   DateTime now = DateTime.now();
    //   DateTime timestamp =
    //       DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    //   Duration difference = now.difference(timestamp);
    //   if (difference.inDays > 0) {
    //     return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    //   } else if (difference.inHours > 0) {
    //     return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    //   } else if (difference.inMinutes > 0) {
    //     return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    //   } else {
    //     return 'Just now';
    //   }
    // }
    // String capitalizeFirstLetter(String input) {
    //   if (input.isEmpty) {
    //     return input;
    //   }
    //   return input[0].toUpperCase() + input.substring(1);
    // }

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
            _buildRowWithColoredContainers(
              "Submission Id",
              "${submission['id']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 72, 255),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Submission Time",
              DateTime.fromMillisecondsSinceEpoch(
                      submission['creationTimeSeconds'] * 1000)
                  .toString()
                  .substring(0, 19),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Author",
              "${submission['author']['members'][0]['handle']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Problem",
              "${submission['problem']['index']} - ${submission['problem']['name']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 72, 255),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Language",
              "${submission['programmingLanguage']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Verdict",
              submission['verdict'] == "OK"
                  ? "ACCEPTED"
                  : "${submission['verdict']}",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              submission['verdict'] == "OK"
                  ? const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )
                  : const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 72, 255),
                    ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Time",
              "${submission['timeConsumedMillis']} ms",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildRowWithColoredContainers(
              "Memory",
              "${submission['memoryConsumedBytes'] ~/ 1024} KB",
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => SubmissionCode(
                //                 contestid: submission['contestId'],
                //                 submissionId: submission['id'],
                //               ),
                //             ),
                //           );
              },
              child: const Text("See Code"),
            ),
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
              // color: leftColor,
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
              // color: rightColor,
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
}
