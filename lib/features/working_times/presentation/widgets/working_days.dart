import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/working_times_bloc.dart';
import 'drop_down_form_day_widget.dart';
import '../../../../core/constants.dart';
import 'working_periods.dart';

class WorkingDays extends StatelessWidget {
  int indexDay;
  String value;
  List<WorkingPeriods> periods;

  WorkingDays(
      {super.key,
      required this.indexDay,
      this.value = 'Sunday',
      required this.periods});

  @override
  Widget build(BuildContext context) {
    final WorkingTimesBloc workingTimesBloc= BlocProvider.of<WorkingTimesBloc>(context);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: FormDay(
                hintText: value,
                items: Constants.weekDays,
                widthForm: 0.25,
                index: indexDay,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                  onPressed: () {
                   workingTimesBloc
                        .add(DeleteDayEvent(indexDay: indexDay));
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 15,
                    color: Color(0xffA80000),
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<WorkingTimesBloc, WorkingTimesState>(
          builder: (context, state) {
            periods =workingTimesBloc
                .workingDays[indexDay]
                .periods;

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: periods.length,
              itemBuilder: (context, index) {
                return WorkingPeriods(
                  indexDay: indexDay,
                  indexPeriod: index,
                  firstTime: periods[index].firstTime,
                  secondTime: periods[index].secondTime,
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 4,
                color: Constants.cyanColoraec6cf,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Constants.cyanColoraec6cf,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    int newIndexPeriod = periods.length;
                   workingTimesBloc.add(
                      AddWorkPeriodEvent(
                        period: WorkingPeriods(
                          indexDay: indexDay,
                          indexPeriod: newIndexPeriod,
                        ),
                        indexDay: indexDay,
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
