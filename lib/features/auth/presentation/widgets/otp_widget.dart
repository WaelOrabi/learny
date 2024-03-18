import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../bloc/verify_account/verify_account_bloc.dart';

class OTPWidget extends StatelessWidget {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String? email;
  final Function({String? email, required String code}) onVerifyAccount;

  OTPWidget({Key? key, this.email, required this.onVerifyAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: controllers.asMap().entries.map((entry) {
        int index = entry.key;
        TextEditingController controller = entry.value;
        FocusNode rawKeyboardListenerFocusNode = FocusNode();

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(focusNodes[index]);
          },
          child: SizedBox(
            width: 40,
            child: RawKeyboardListener(
              focusNode: rawKeyboardListenerFocusNode,
              onKey: (RawKeyEvent event) {
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                      index < controllers.length - 1) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
                      index > 0) {
                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                  } else if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      controller.text.isEmpty &&
                      index > 0) {
                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                  }
                }
              },
              child: TextFormField(
                controller: controller,
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Constants.secondaryColor),
                onChanged: (value) {
                  if (value.isNotEmpty && index < controllers.length - 1) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  }
                  if (value.isNotEmpty && index == controllers.length - 1) {
                    String code = controllers.map((e) => e.text).join();
                    onVerifyAccount(email: email, code: code);
                  }
                },
                decoration: InputDecoration(
                  hoverColor: Constants.primaryColor,
                  filled: true,
                  fillColor: Constants.primaryColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: Constants.cyanColoraec6cf),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Constants.primaryColor),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
