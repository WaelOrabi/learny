
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/working_times_bloc.dart';

import '../../../../core/widgets/custom_dropdown_button_widget.dart';

class FormDay extends StatelessWidget {
  final  int index;
   FormDay(
      {super.key,
        required this.hintText,
        required this.items,
        this.index=0,
        this.value,
        this.widthForm = 1});

  final String hintText;
  final List<String> items;
  String?value;

  final double widthForm;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: CustomDropdownButtonWidget(
        value: value,
        hintText: hintText,
        items: items,
        widthForm: widthForm,
        onChanged: (value) {

          BlocProvider.of<WorkingTimesBloc>(context)
              .add(UpdateDayEvent(day: value!, index: index));
        },
      ),
    );
  }
}


