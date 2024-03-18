import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../../core/widgets/toast_widget.dart';
import '../bloc/working_times_bloc.dart';
import '../widgets/working_days.dart';
import '../widgets/working_periods.dart';
import '../../../../core/constants.dart';
import '../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../data/models/working_times_model.dart';

class WorkingTimes extends StatelessWidget {
  const WorkingTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkingTimesBloc workingTimesBloc =
        BlocProvider.of<WorkingTimesBloc>(context);
    return Scaffold(
      body: _buildBody(workingTimesBloc: workingTimesBloc),
    );
  }

  LayoutBuilder _buildBody({required workingTimesBloc}) {
    return LayoutBuilder(builder: (context, constraints) {
      final MediaQueryData mediaQuery = MediaQuery.of(context);

      final double screenHeight = mediaQuery.size.height;
      final double textScaleFactor = mediaQuery.textScaleFactor;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Assign Working Time',
              style: MyAppTheme.myTheme.textTheme.displayLarge,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 50, right: constraints.maxWidth * 0.5, bottom: 20),
              child: const Text(
                'Assign working time:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            BlocBuilder<WorkingTimesBloc, WorkingTimesState>(
                builder: (context, state) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: workingTimesBloc.workingDays.length,
                  itemBuilder: (context, index) {
                    return WorkingDays(
                      indexDay: index,
                      periods: workingTimesBloc.workingDays[index].periods,
                      value: workingTimesBloc.workingDays[index]
                          .value, // Assuming 'value' is a property of the WorkingDays class
                    );
                  });
            }),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Constants.cyanColoraec6cf,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.black),
                      onPressed: () {
                        int newIndexDay = workingTimesBloc.workingDays.length;
                        workingTimesBloc.add(
                          AddWorkDayEvent(
                            day: WorkingDays(
                              periods: [
                                WorkingPeriods(
                                  indexDay: newIndexDay,
                                  indexPeriod: 0,
                                ),
                              ],
                              indexDay: newIndexDay,
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 4,
                    color: Constants.cyanColoraec6cf,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.06,
            ),
            BlocConsumer<WorkingTimesBloc, WorkingTimesState>(
              listener: (context, state) async {
                if (state is AssignWorkingTimeSucess) {
                  showToastWidgetSuccess(
                      'The working times are set successfully');
                } else if (state is AssignWorkingTimeFail) {
                  for (int i = 0; i < state.message.length; i++) {
                    showToastWidgetError(state.message[i]!);
                    await Future.delayed(const Duration(seconds: 4));
                  }
                }
              },
              builder: (context, state) {
                return MyElevatedButton(
                  width: constraints.maxWidth * 0.12,
                  height: screenHeight * Constants.heightElevatedButton,
                  onPressed: () {
                    List<WorkingDaysModel> workingDaysModel =
                        createWorkingDaysModelList(
                            workingTimesBloc.workingDays);
                    workingTimesBloc.add(AssignWorkingTimeEvent(
                        workingTimesModel: AssignWorkingTimeModel(
                            workingDays: workingDaysModel)));
                  },
                  child: state is AssignWorkingTimeLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Constants.secondaryColor,
                          ),
                        )
                      : Text(
                          Constants.submit,
                          style: TextStyle(
                            color: Constants.primaryColor,
                            fontSize: Constants.fontSizeWordsInsideButtons *
                                textScaleFactor,
                          ),
                        ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  int getDayId(String dayValue) {
    switch (dayValue) {
      case "Sunday":
        return 1;
      case "Monday":
        return 2;
      case "Tuesday":
        return 3;
      case "Wednesday":
        return 4;
      case "Thursday":
        return 5;
      case "Friday":
        return 6;
      case "Saturday":
        return 7;
      default:
        return 0;
    }
  }

  WorkingTimesModel createWorkingTimesModel(period) {
    return WorkingTimesModel(
      first: DateFormat('HH:mm').format(
          DateTime(0, 0, 0, period.firstTime!.hour, period.firstTime!.minute)),
      end: DateFormat('HH:mm').format(DateTime(
          0, 0, 0, period.secondTime!.hour, period.secondTime!.minute)),
    );
  }

  List<WorkingDaysModel> createWorkingDaysModelList(workingDays) {
    List<WorkingDaysModel> workingDaysModel = [];
    for (var day in workingDays) {
      WorkingDaysModel model =
          WorkingDaysModel(dayId: getDayId(day.value), workingTimes: []);
      for (var period in day.periods) {
        model.workingTimes.add(createWorkingTimesModel(period));
      }
      workingDaysModel.add(model);
    }
    return workingDaysModel;
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Constants.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: InkWell(
              child: Container(
                width: 120,
                height: 50,
                decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: Constants.cyanColorCombination),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Center(
                    child: Text(
                  'Working Times',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )),
              ),
            ),
          ),
        ],
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          foregroundImage: AssetImage('assets/images/logo_white.png'),
          radius: 15,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Constants.cyanColoraec6cf,
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 10),
          child: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                  foregroundImage: AssetImage('assets/images/profile.png'),
                  radius: 15)),
        ),
      ],
    );
  }
}
