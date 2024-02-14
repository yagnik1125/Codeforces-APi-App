import 'package:apiapp/widgets/custom_code_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/services.dart';

class ProblemStatement extends StatefulWidget {
  final dynamic contestid;
  final dynamic problemIndex;
  const ProblemStatement({Key? key, required this.contestid, this.problemIndex})
      : super(key: key);

  @override
  State<ProblemStatement> createState() => _ProblemStatementState();
}

class _ProblemStatementState extends State<ProblemStatement> {
  // String? problemstatement;
  // String? headerstatement;
  String? title;
  String? timelimit;
  String? memorylimit;
  String? inputfile;
  String? outputfile;
  String? problemparagraph;
  String? inputstatement;
  String? sampleinput;
  String? sampleoutput;
  String? inputspecification;
  String? outputstatement;
  String? outputspecification;
  String? note;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProblemStatement();
  }

  //-----------------------------------------------------------------------------------------
  String replaceLatexSyntax(String input) {
    return input.replaceAllMapped(
      RegExp(r'\$\$\$(.*?)\$\$\$'),
      (match) => '\\(${match.group(1)}\\)',
    );
  }
  //-----------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------
  String extractDataFromHtmlInput(String htmlString) {
    final document = parse(htmlString);
    final preElement = document.querySelector('pre');
    if (preElement != null) {
      String preText = preElement.innerHtml.trim();
      return extractLinesInput(preText);
    } else {
      return 'Data not found';
    }
  }

  String extractLinesInput(String text) {
    // Replace line-specific HTML tags with newline characters
    text = text.replaceAllMapped(
      RegExp(r'<div class="test-example-line.*?">'),
      (match) => '\n',
    );
    text = text.replaceAll('</div>', ''); // Remove remaining div tags

    return text.trim();
  }

  String extractDataFromHtmlOutput(String htmlString) {
    final document = parse(htmlString);
    final preElement = document.querySelector('pre');
    if (preElement != null) {
      String preText = preElement.text.trim();
      return extractLinesOutput(preText);
    } else {
      return 'Data not found';
    }
  }

  String extractLinesOutput(String text) {
    return text.trim();
  }
  //-----------------------------------------------------------------------------------------

  // //---------------------------------------------------------------------------------------
  // void fetchProblemStatement() async {
  //   print("fetch called in pro stat");
  //   final contestId = widget.contestid;
  //   final problemIndex = widget.problemIndex;
  //   final url =
  //       'https://codeforces.com/contest/$contestId/problem/$problemIndex';
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final document = parse(response.body);
  //     // Extract the problem statement
  //     setState(() {
  //       problemstatement =
  //           document.querySelector('.problem-statement')?.innerHtml;
  //       problemstatement = replaceLatexSyntax(problemstatement ?? "");
  //       print(problemstatement);
  //       print('Fetch completed in pro stat');
  //       isLoading = false;
  //     });
  //   } else {
  //     print(
  //         'Failed to fetch the problem statement. Status code: ${response.statusCode}');
  //   }
  // }
  // //---------------------------------------------------------------------------------------

  void fetchProblemStatement() async {
    print("fetch called in pro stat");
    final contestId = widget.contestid;
    final problemIndex = widget.problemIndex;
    final url =
        'https://codeforces.com/contest/$contestId/problem/$problemIndex';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parse(response.body);

      // Extract the problem statement
      final problemStatementDiv = document.querySelector('.problem-statement');
      final paragraphdiv = problemStatementDiv?.getElementsByTagName('div')[10];
      final headerDiv = document.querySelector('.header');
      final titleDiv = headerDiv?.querySelector('.title');
      final timelimitDiv = headerDiv?.querySelector('.time-limit');
      final memorylimitDiv = headerDiv?.querySelector('.memory-limit');
      final inputfileDiv = headerDiv?.querySelector('.input-file');
      final inputspecificationDiv =
          document.querySelector('.input-specification');
      final outputfileDiv = headerDiv?.querySelector('.output-file');
      final outputspecificationDiv =
          document.querySelector('.output-specification');
      final inputstatementDiv = document.querySelector('.input');
      final outputstatementDiv = document.querySelector('.output');
      final noteDiv = document.querySelector('.note');

      setState(() {
        // Extracting problem statement
        // problemstatement = problemStatementDiv?.innerHtml;
        // problemstatement = replaceLatexSyntax(problemstatement ?? "");
        // print(
        //     "problemstatement------------------------------------------------------------------\n");
        // print(problemstatement);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting input div
        inputstatement = inputstatementDiv?.innerHtml;
        inputstatement = replaceLatexSyntax(inputstatement ?? "");
        // print(
        //     "inputstatement------------------------------------------------------------------\n");
        // print(inputstatement);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting output div
        outputstatement = outputstatementDiv?.innerHtml;
        outputstatement = replaceLatexSyntax(outputstatement ?? "");
        // print(
        //     "outputstatement------------------------------------------------------------------\n");
        // print(outputstatement);
        // print(
        //     "------------------------------------------------------------------\n");

        sampleinput = extractDataFromHtmlInput(inputstatement.toString());
        sampleoutput = extractDataFromHtmlOutput(outputstatement.toString());
        // print("sampleInput------------------------\n$sampleinput \n");
        // print("sampleoutput------------------------\n$sampleoutput \n");

        // Extracting header div
        // headerstatement = headerDiv?.innerHtml;
        // headerstatement = replaceLatexSyntax(headerstatement ?? "");
        // print(
        //     "outputstatement------------------------------------------------------------------\n");
        // print(headerstatement);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting title div
        title = titleDiv?.innerHtml;
        title = replaceLatexSyntax(title ?? "");
        // print(
        //     "title------------------------------------------------------------------\n");
        // print(title);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting timelimit div
        timelimit = timelimitDiv?.innerHtml;
        timelimit = replaceLatexSyntax(timelimit ?? "");
        // print(
        //     "timelimit------------------------------------------------------------------\n");
        // print(timelimit);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting memorylimit div
        memorylimit = memorylimitDiv?.innerHtml;
        memorylimit = replaceLatexSyntax(memorylimit ?? "");
        // print(
        //     "memorylimit------------------------------------------------------------------\n");
        // print(memorylimit);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting inputfile div
        inputfile = inputfileDiv?.innerHtml;
        inputfile = replaceLatexSyntax(inputfile ?? "");
        // print(
        //     "inputfile------------------------------------------------------------------\n");
        // print(inputfile);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting inputspecification div
        inputspecification = inputspecificationDiv?.innerHtml;
        inputspecification = replaceLatexSyntax(inputspecification ?? "");
        // print(
        //     "inputspecification------------------------------------------------------------------\n");
        // print(inputspecification);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting outputfile div
        outputfile = outputfileDiv?.innerHtml;
        outputfile = replaceLatexSyntax(outputfile ?? "");
        // print(
        //     "outputfile------------------------------------------------------------------\n");
        // print(outputfile);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting outputspecification div
        outputspecification = outputspecificationDiv?.innerHtml;
        outputspecification = replaceLatexSyntax(outputspecification ?? "");
        // print(
        //     "outputspecification------------------------------------------------------------------\n");
        // print(outputspecification);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting problemparagraph div
        problemparagraph = paragraphdiv?.innerHtml;
        problemparagraph = replaceLatexSyntax(problemparagraph ?? "");
        // print(
        //     "problemparagraph------------------------------------------------------------------\n");
        // print(problemparagraph);
        // print(
        //     "------------------------------------------------------------------\n");

        // Extracting title div
        note = noteDiv?.innerHtml;
        note = replaceLatexSyntax(note ?? "");
        // print(
        //     "note------------------------------------------------------------------\n");
        // print(note);
        // print(
        //     "------------------------------------------------------------------\n");

        // You can continue extracting other div elements in a similar manner

        print('Fetch completed in pro stat');
        isLoading = false;
      });
    } else {
      print(
          'Failed to fetch the problem statement. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    //-------code editor-------------------------------------------------
    final preset = <String>[
      // "dart|monokai-sublime",
      // "python|atom-one-dark",
      "cpp|monokai-sublime",
      // "java|a11y-dark",
      // "javascript|vs",
    ];
    List<Widget> children = preset.map((e) {
      final parts = e.split('|');
      // print(parts);
      final box = CustomCodeBox(
        language: parts[0],
        theme: parts[1],
      );
      return Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: box,
      );
    }).toList();
    final page = Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(children: children),
      ),
    );
    //-------code editor-------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text("Codeforces Problem"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TeXView(
                          child: TeXViewColumn(
                            children: [
                              TeXViewDocument(
                                title.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Center,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 22,
                                  ),
                                  padding: const TeXViewPadding.all(8),
                                ),
                              ),
                              TeXViewDocument(
                                timelimit.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Center,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TeXViewDocument(
                                memorylimit.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Center,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TeXViewDocument(
                                inputfile.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Center,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TeXViewDocument(
                                outputfile.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Center,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TeXViewDocument(
                                problemparagraph.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Left,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 14,
                                  ),
                                  padding: const TeXViewPadding.only(
                                    top: 12,
                                    bottom: 12,
                                    right: 8,
                                    left: 8,
                                  ),
                                ),
                              ),
                              TeXViewDocument(
                                inputspecification.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Left,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 14,
                                  ),
                                  padding: const TeXViewPadding.all(8),
                                ),
                              ),
                              TeXViewDocument(
                                outputspecification.toString(),
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Left,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 14,
                                  ),
                                  padding: const TeXViewPadding.all(8),
                                ),
                              ),
                              TeXViewDocument(
                                "Example",
                                style: TeXViewStyle(
                                  textAlign: TeXViewTextAlign.Left,
                                  fontStyle: TeXViewFontStyle(
                                    fontSize: 16,
                                    fontWeight: TeXViewFontWeight.bold,
                                  ),
                                  padding: const TeXViewPadding.all(8),
                                ),
                              ),
                              // TeXViewDocument(
                              //   inputstatement.toString(),
                              //   style: TeXViewStyle(
                              //     elevation: 5,
                              //     textAlign: TeXViewTextAlign.Left,
                              //     fontStyle: TeXViewFontStyle(
                              //       fontSize: 16,
                              //     ),
                              //     padding: const TeXViewPadding.all(8),
                              //   ),
                              // ),
                              // TeXViewDocument(
                              //   outputstatement.toString(),
                              //   style: TeXViewStyle(
                              //     elevation: 5,
                              //     textAlign: TeXViewTextAlign.Left,
                              //     fontStyle: TeXViewFontStyle(
                              //       fontSize: 16,
                              //     ),
                              //     padding: const TeXViewPadding.all(8),
                              //   ),
                              // ),
                              // TeXViewDocument(
                              //   // r"""<p>There are $$$n$$$ points numbered $$$1$$$ to $$$n$$$ on a straight line. Initially, there are $$$m$$$ harbours. The $$$i$$$-th harbour is at point $$$X_i$$$ and has a value $$$V_i$$$.</p>""",
                              //   // r"""<p>There are \(n\) points numbered \(1\) to \(n\) on a straight line. Initially, there are \(m\) harbours. The \(i\)-th harbour is at point \(X_i\) and has a value \(V_i\).</p>""",
                              //   note.toString(),
                              //   style: TeXViewStyle(
                              //     textAlign: TeXViewTextAlign.Left,
                              //     fontStyle: TeXViewFontStyle(
                              //       fontSize: 14,
                              //     ),
                              //     padding: const TeXViewPadding.all(8),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        //-------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Input",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: sampleinput.toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Copied to clipboard')),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                        ),
                        // TeXView(
                        //   child: TeXViewDocument(
                        //     inputstatement.toString(),
                        //     style: TeXViewStyle(
                        //       elevation: 5,
                        //       textAlign: TeXViewTextAlign.Left,
                        //       fontStyle: TeXViewFontStyle(
                        //         fontSize: 16,
                        //       ),
                        //       padding: const TeXViewPadding.all(8),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: TextField(
                            readOnly: true,
                            maxLines: null,
                            controller:
                                TextEditingController(text: sampleinput),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Output",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: sampleoutput.toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Copied to clipboard')),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                        ),
                        // TeXView(
                        //   child: TeXViewDocument(
                        //     outputstatement.toString(),
                        //     style: TeXViewStyle(
                        //       elevation: 5,
                        //       textAlign: TeXViewTextAlign.Left,
                        //       fontStyle: TeXViewFontStyle(
                        //         fontSize: 16,
                        //       ),
                        //       padding: const TeXViewPadding.all(8),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: TextField(
                            readOnly: true,
                            maxLines: null,
                            controller:
                                TextEditingController(text: sampleoutput),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        TeXView(
                          child: TeXViewDocument(
                            note.toString(),
                            style: TeXViewStyle(
                              elevation: 5,
                              textAlign: TeXViewTextAlign.Left,
                              fontStyle: TeXViewFontStyle(
                                fontSize: 16,
                              ),
                              padding: const TeXViewPadding.all(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(child: page),
                ],
              ),
            ),
    );
  }
}


// //-------------------------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:webview_flutter/webview_flutter.dart';
// class ProblemStatement extends StatefulWidget {
//   final contestid;
//   final problemIndex;
//   const ProblemStatement({Key? key, required this.contestid, this.problemIndex})
//       : super(key: key);
//   @override
//   State<ProblemStatement> createState() => _ProblemStatementState();
// }
// class _ProblemStatementState extends State<ProblemStatement> {
//   String? problemstatement;
//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     fetchProblemStatement();
//   }
//   void fetchProblemStatement() async {
//     try {
//       final contestId = widget.contestid;
//       final problemIndex = widget.problemIndex;
//       final url = 'https://codeforces.com/contest/$contestId/problem/$problemIndex';
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final document = parse(response.body);
//         setState(() {
//           problemstatement = document.querySelector('.problem-statement')?.innerHtml;
//           isLoading = false;
//         });
//       } else {
//         print('Failed to fetch the problem statement. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching or parsing data: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Codeforces contest Api Demo"),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : WebView(
//               initialUrl: 'about:blank',
//               onWebViewCreated: (controller) {
//                 controller.loadUrl(Uri.dataFromString(
//                   problemstatement ?? "",
//                   mimeType: 'text/html',
//                   // encoding: 'utf-8',
//                 ).toString());
//               },
//               javascriptMode: JavascriptMode.unrestricted,
//             ),
//     );
//   }
// }

//--------------------------------------------------------------------------------------------
// String replaceLatexSyntax(String input) {
//   return input.replaceAllMapped(
//     RegExp(r'\$\$\$(.*?)\$\$\$'),
//     (match) => '\\(${match.group(1)}\\)',
//   );
// }
//--------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:flutter_tex/flutter_tex.dart';
// class ProblemStatement extends StatefulWidget {
//   final contestid;
//   final problemIndex;
//   const ProblemStatement({Key? key, required this.contestid, this.problemIndex})
//       : super(key: key);
//   @override
//   State<ProblemStatement> createState() => _ProblemStatementState();
// }
// class _ProblemStatementState extends State<ProblemStatement> {
//   String? problemstatement;
//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     fetchProblemStatement();
//   }
//   void fetchProblemStatement() async {
//     try {
//       final contestId = widget.contestid;
//       final problemIndex = widget.problemIndex;
//       final url =
//           'https://codeforces.com/contest/$contestId/problem/$problemIndex';
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final document = parse(response.body);
//         setState(() {
//           problemstatement =
//               document.querySelector('.problem-statement')?.innerHtml;
//           isLoading = false;
//         });
//       } else {
//         print(
//             'Failed to fetch the problem statement. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching or parsing data: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Codeforces contest Api Demo"),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : const TeXView(
//               child: TeXViewColumn(children: [
//                 TeXViewInkWell(
//                   id: "id_0",
//                   child: TeXViewColumn(children: [
//                     TeXViewDocument(
//                         // r"""<p>There are $$$n$$$ points numbered $$$1$$$ to $$$n$$$ on a straight line. Initially, there are $$$m$$$ harbours. The $$$i$$$-th harbour is at point $$$X_i$$$ and has a value $$$V_i$$$.</p>""",
//                         r"""<p>There are \(n\) points numbered \(1\) to \(n\) on a straight line. Initially, there are \(m\) harbours. The \(i\)-th harbour is at point \(X_i\) and has a value \(V_i\).</p>""",
//                         style:
//                             TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
//                     TeXViewContainer(
//                       child: TeXViewImage.network(
//                           'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
//                       style: TeXViewStyle(
//                         margin: TeXViewMargin.all(10),
//                         borderRadius: TeXViewBorderRadius.all(20),
//                       ),
//                     ),
//                     TeXViewDocument(r"""<p>
//                        When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
//                        $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
//                         style: TeXViewStyle.fromCSS(
//                             'padding: 15px; color: white; background: green'))
//                   ]),
//                 )
//               ]),
//               style: TeXViewStyle(
//                 elevation: 10,
//                 borderRadius: TeXViewBorderRadius.all(25),
//                 border: TeXViewBorder.all(TeXViewBorderDecoration(
//                     borderColor: Colors.blue, borderWidth: 5)),
//                 backgroundColor: Colors.white,
//               ),
//             ),
//     );
//   }
// }
