import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final String tag;
  final Function(String) onTagChanged;

  const TagBox({Key? key, required this.tag, required this.onTagChanged})
      : super(key: key);

  @override
  State<TagBox> createState() => _TagBoxState();
}

class _TagBoxState extends State<TagBox> {
  String? tag;

  @override
  void initState() {
    super.initState();
    tag = widget.tag;
  }

  List<String?> get tagsList {
    const tags = <String>{
      "implementation",
      "math",
      "greedy",
      "data structures",
      "dp",
      "graph matching",
      "graphs",
      "strings",
      "dfs and similar",
      "brute force",
      "binary search",
      "ternary search",
      "bitmasks",
      "combinatorics",
      "geometry",
      "number theory",
      "trees",
      "sortings",
      "two pointers",
      "divide and conquer",
      "constructive algorithms",
      "flows",
      "shortest paths",
      "hashing",
      "games",
      "dfs order",
      "dsu",
      "string suffix structures",
      "expression parsing",
      "meet-in-the-middle",
      "suffix structures",
      "matrices",
      "probabilities",
      "fft",
      "schedules",
      "2-sat",
      "chinese remainder theorem",
      "",
    };
    return <String?>[
      ...tags,
    ];
  }

  Widget buildDropdown(Iterable<String?> choices, String value, IconData icon,
      Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 8,
          ),
          DropdownButton<String>(
            value: value,
            items: choices.map((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == null
                    ? const Divider()
                    : Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
              );
            }).toList(),
            icon: Icon(icon, color: Colors.black),
            onChanged: (val) => onChanged(val ?? ""),
            dropdownColor: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tagsDropdown =
        buildDropdown(tagsList, tag!, Icons.arrow_drop_down_sharp, (val) {
      if (val == null) return;
      setState(() => tag = val);
      widget.onTagChanged(val);
    });
    final dropdowns = Row(children: [
      const SizedBox(width: 12.0),
      tagsDropdown,
    ]);
    return Column(children: [
      dropdowns,
    ]);
  }
}

// class InnerField extends StatefulWidget {
//   final String language;
//   final String theme;
//   const InnerField({Key? key, required this.language, required this.theme})
//       : super(key: key);
//   @override
//   State<InnerField> createState() => _InnerFieldState();
// }
// class _InnerFieldState extends State<InnerField> {
//   CodeController? _codeController;
//   @override
//   void initState() {
//     super.initState();
//     _codeController = CodeController(
//       text: codeSnippets[widget.language],
//       patternMap: {
//         r"\B#[a-zA-Z0-9]+\b": const TextStyle(color: Colors.red),
//         r"\B@[a-zA-Z0-9]+\b": const TextStyle(
//           fontWeight: FontWeight.w800,
//           color: Colors.blue,
//         ),
//         r"\B![a-zA-Z0-9]+\b":
//             const TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic),
//       },
//       stringMap: {
//         "bev": const TextStyle(color: Colors.indigo),
//       },
//       language: allLanguages[widget.language],
//     );
//   }
//   @override
//   void dispose() {
//     _codeController?.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final styles = themes[widget.theme];
//     if (styles == null) {
//       return _buildCodeField();
//     }
//     return CodeTheme(
//       data: CodeThemeData(styles: styles),
//       child: _buildCodeField(),
//     );
//   }
//   Widget _buildCodeField() {
//     return CodeField(
//       controller: _codeController!,
//       textStyle: const TextStyle(fontFamily: 'SourceCode'),
//     );
//   }
// }
