
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_dropdown_button_widget.dart';

class FormGender extends StatelessWidget {
   FormGender(
      {super.key,
      required this.hintText,
      required this.items,
        required this.onChanged,
      this.widthForm = 1, required this.value});

  final String hintText;
   final String? value;
  final List<String> items;
final Function(String?) onChanged;
  final double widthForm;

@override
 Widget build(BuildContext context) {
   return DropdownButtonHideUnderline(
     child: CustomDropdownButtonWidget(
       items: items,
       value: value,
       hintText: hintText,
       widthForm: widthForm,
       onChanged: onChanged,
     ),
   );
 }
}


