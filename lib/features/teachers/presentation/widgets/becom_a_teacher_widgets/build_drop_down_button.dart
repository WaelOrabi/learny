import 'package:flutter/material.dart';
Widget buildDropdownButton({required String value, required List<String> items,required ValueChanged<String?> onChange}) {
      return DropdownButton<String>(
        value: value,
        focusColor: Colors.white,
        onChanged: onChange,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            key: UniqueKey(),
            value: value,
            child: Text(value),
          );
        }).toList(),
        dropdownColor: Colors.white,
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
      );

}


