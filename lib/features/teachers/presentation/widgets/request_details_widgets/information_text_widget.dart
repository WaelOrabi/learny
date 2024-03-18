import 'package:flutter/material.dart';

import '../../../../../core/theme/my_App_Theme.dart';
class InformationTextWidget extends StatelessWidget {
  final String text;
  final String? value;
  const InformationTextWidget({Key? key, required this.text, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                    MyAppTheme.myTheme.textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                    MyAppTheme.myTheme.textTheme.titleMedium!.fontSize)),
          ],
        ),
      ),
    );
  }
}
