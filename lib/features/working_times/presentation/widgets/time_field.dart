import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/working_times_bloc.dart';

import '../../../../core/constants.dart';

class TimeField extends StatefulWidget {
  bool first;
  bool second;
  final int indexDay;
  final int indexPeriod;
  TimeOfDay? firstTime;
  TimeOfDay? secondTime;

  TimeField(
      {super.key,
      this.first = false,
      this.second = false,
      this.firstTime,
      this.secondTime,
      required this.indexDay,
      required this.indexPeriod});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.firstTime != null
        ? DateFormat("hh:mm ").format(DateTimeField.convert(widget.firstTime)!)
        : widget.secondTime != null
            ? DateFormat("hh:mm ")
                .format(DateTimeField.convert(widget.secondTime)!)
            : '';

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WorkingTimesBloc workingTimesBloc= BlocProvider.of<WorkingTimesBloc>(context);
    _controller.text = widget.firstTime != null
        ? DateFormat("hh:mm a").format(DateTimeField.convert(widget.firstTime)!)
        : widget.secondTime != null
            ? DateFormat("hh:mm a")
                .format(DateTimeField.convert(widget.secondTime)!)
            : '';
    return Container(
      constraints: const BoxConstraints(maxWidth: 150, maxHeight: 70),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Constants.cyanColoraec6cf),
      ),
      child: DateTimeField(
        format: DateFormat("HH:mm"),
        controller: _controller,
       decoration: const InputDecoration(
         contentPadding: EdgeInsets.only(left: 20),
          border: InputBorder.none,
          suffixIcon: SizedBox(width: 0, height: 0),
        ),
        onShowPicker: (context, currentValue) async {
          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            useRootNavigator: false,
          );
          if (time != null) {
            _controller.text =
                DateFormat("hh:mm a").format(DateTimeField.convert(time)!);
          }
          if (widget.first == true && time != null) {
            workingTimesBloc.add(
                UpdateBeginningPeriodEvent(
                    beginningPeriod: time,
                    indexDay: widget.indexDay,
                    indexPeriod: widget.indexPeriod));
          } else if (widget.second == true && time != null) {
           workingTimesBloc.add(UpdateEndPeriodEvent(
                endPeriod: time,
                indexDay: widget.indexDay,
                indexPeriod: widget.indexPeriod));
          }
          return time == null ? null : DateTimeField.convert(time);
        },
      ),
    );
  }
}
