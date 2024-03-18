import 'package:flutter/material.dart';
import '../../../../../core/theme/my_App_Theme.dart';
class ExpandableText extends StatelessWidget {
  final String text;
  final dynamic maxLines;
  final double width;

  const ExpandableText({super.key, required this.text, this.maxLines,  this.width=double.infinity});
  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: width,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0,
        children: [
          ..._getLines(text,maxLines).map((line) =>Text(line,style:TextStyle(color:Colors.black,fontSize:  MyAppTheme.myTheme.textTheme.titleMedium!.fontSize),) ),

        ],
      ),
    );
  }


  List<String> _getLines(String text, int? maxLines) {
    List<String> words = text.split(' ');
    List<String> lines = [];
    String line = '';
    int count = 0;
    for (int i = 0; i < words.length; i++) {
      if (maxLines != null && count >= maxLines) {
        break;
      }
      if ((line + words[i]).length > 20) { // set the maximum number of characters per line
        lines.add(line.trim());
        line = '${words[i]} ';
        count++;
      } else {
        line += '${words[i]} ';
      }
    }
    lines.add(line.trim());
    return lines;
  }
}
