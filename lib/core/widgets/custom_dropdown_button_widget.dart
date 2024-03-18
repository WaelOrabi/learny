import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/my_App_Theme.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
   String? value;
  final List<String> items;
  final double widthForm;
  final Function(String?) onChanged;
  final String hintText;
   CustomDropdownButtonWidget({
    Key? key,
     this.value,
    required this.hintText,
    required this.items,
    required this.widthForm,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      alignment: Alignment.center,
      hint: _buildHintText(),
      items: _buildMenuItems(),
      value:value,
      onChanged: onChanged,
      buttonStyleData: _buildButtonStyleData(context),
      iconStyleData: _buildIconStyleData(),
      dropdownStyleData: _buildDropdownStyleData(context),
      menuItemStyleData: _buildMenuItemStyleData(),
    );
  }

  Widget _buildHintText() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        hintText,
        style: MyAppTheme.myTheme.inputDecorationTheme.hintStyle,

             textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMenuItems() {

    return items
        .map((item) => DropdownMenuItem<String>(

      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ))
        .toList();
  }

  ButtonStyleData _buildButtonStyleData(BuildContext context) {
    return ButtonStyleData(
      height: 50,
      width: MediaQuery.of(context).size.width * widthForm,
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xffaec6cf),
        ),
        color: Colors.white,
      ),
    );
  }

  IconStyleData _buildIconStyleData() {
    return const IconStyleData(
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
      ),
      iconSize: 30,
    );
  }

  DropdownStyleData _buildDropdownStyleData(BuildContext context) {
    return DropdownStyleData(

      maxHeight: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 2.8,
      padding: null,
       useRootNavigator: true,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      elevation: 4,
      offset: const Offset(-20, 20),

    );
  }

  MenuItemStyleData _buildMenuItemStyleData() {
    return const MenuItemStyleData(
      height: 30,
      padding: EdgeInsets.only(left: 14, right: 14),
    );
  }
}
