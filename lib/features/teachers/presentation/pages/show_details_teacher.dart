import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/auth/presentation/widgets/ElvatedButtonWdget.dart';
import 'package:learny_project/features/teachers/presentation/bloc/get_teacher/get_teacher_bloc.dart';
import 'package:learny_project/features/teachers/presentation/widgets/becom_a_teacher_widgets/footer.dart';
import 'package:learny_project/features/teachers/presentation/widgets/show_details_teacher/display_video_youtube.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/widgets/toast_widget.dart';
import '../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../../../appointment/presentation/bloc/get_goals_bloc/get_goals_bloc.dart';
import '../../../appointment/presentation/pages/make_appointment.dart';
import '../widgets/request_details_widgets/display_video.dart';
import '../widgets/show_details_teacher/available_time.dart';

class ShowDetailsTeacher extends StatefulWidget {
  final int teacherId;

  const ShowDetailsTeacher({Key? key, required this.teacherId})
      : super(key: key);

  @override
  State<ShowDetailsTeacher> createState() => _ShowDetailsTeacherState();
}

class _ShowDetailsTeacherState extends State<ShowDetailsTeacher> {
  bool _isExpandedAboutMe = false;
  bool _isExpandedTeaching = false;
  VideoPlayerController? _controller;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String hourBooking = "";
  bool isSelected = false;
  int? _selectedIndex;

  @override
  void initState() {
    BlocProvider.of<GetTeacherBloc>(context)
        .add(GetTeacher(teacherId: widget.teacherId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<GetTeacherBloc, GetTeacherState>(
        listener: (context, state) {
          if (state is GetTeacherErrorState) {
            state.message.map((e) => showToastWidgetError(e)).toList();
          }
        },
        builder: (context, state) {
          if (state is GetTeacherSuccessState) {
            _controller ??=
                VideoPlayerController.network(state.teacher.info.video);
            return Scaffold(
                backgroundColor: Colors.grey.shade100,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0).w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0).w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10).w,
                              ),
                              width: 500.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10).w,
                                        ),
                                        margin: const EdgeInsets.all(20).w,
                                        height: 400.h,
                                        width: 300.w,
                                        child: Image.network(
                                          state.teacher.userInfo
                                                      .personalImage ==
                                                  null
                                              ? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg"
                                              : state.teacher.userInfo
                                                  .personalImage!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "${state.teacher.userInfo.firstName} ${state.teacher.userInfo.lastName}",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Center(
                                      child: Text(
                                        state.teacher.userInfo.phoneNumber,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              state.teacher.rating
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color:
                                                      Colors.yellow.shade600),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow.shade600,
                                              size: 30.w,
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.male,
                                          size: 30.h,
                                        ),
                                        Text(
                                          state.teacher.userInfo.nationality!
                                              .name!,
                                          style: TextStyle(fontSize: 20.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 10)
                                          .w,
                                      child: Text(
                                        "About me: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        constraints: BoxConstraints(
                                          maxWidth: 480.w,
                                        ),
                                        child: Text(
                                          state.teacher.info.about.length < 250
                                              ? state.teacher.info.about
                                              : state.teacher.info.about
                                                  .substring(
                                                      0,
                                                      _isExpandedAboutMe
                                                          ? null
                                                          : 250),
                                          style: TextStyle(fontSize: 18.sp),
                                        )),
                                    if (state.teacher.info.about.length > 250)
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isExpandedAboutMe =
                                                !_isExpandedAboutMe;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              _isExpandedAboutMe
                                                  ? 'see less'
                                                  : 'see more',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                            ),
                                            _isExpandedAboutMe
                                                ? Icon(
                                                    Icons
                                                        .keyboard_double_arrow_up,
                                                    color: Colors.blue,
                                                    size: 15.w,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .keyboard_double_arrow_down,
                                                    color: Colors.blue,
                                                    size: 15.w,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Teaching",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state.teacher.languages.length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    state
                                                        .teacher
                                                        .languages[index1]
                                                        .language,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Level",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state.teacher.languages.length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    state
                                                        .teacher
                                                        .languages[index1]
                                                        .level,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Experience",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state.teacher.languages.length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    "${state.teacher.languages[index1].yearsOfExperience} y",
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 10)
                                          .w,
                                      child: Text(
                                        "Working days: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Days",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state
                                                    .teacher.workingDays.length,
                                                (index1) => Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Column(
                                                        children: state
                                                                .teacher
                                                                .workingDays[
                                                                    index1]
                                                                .workingTimes
                                                                .isEmpty
                                                            ? []
                                                            : List.generate(
                                                                state
                                                                    .teacher
                                                                    .workingDays[
                                                                        index1]
                                                                    .workingTimes
                                                                    .length,
                                                                (index2) =>
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                              6.0)
                                                                          .w,
                                                                  child: Text(
                                                                    index2 == 0
                                                                        ? state
                                                                            .teacher
                                                                            .workingDays[index1]
                                                                            .dayName
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize: 20
                                                                            .sp,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                ),
                                                              )),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "From",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state
                                                    .teacher.workingDays.length,
                                                (index1) => Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Column(
                                                        children: state
                                                                .teacher
                                                                .workingDays[
                                                                    index1]
                                                                .workingTimes
                                                                .isEmpty
                                                            ? []
                                                            : List.generate(
                                                                state
                                                                    .teacher
                                                                    .workingDays[
                                                                        index1]
                                                                    .workingTimes
                                                                    .length,
                                                                (index2) =>
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                              6.0)
                                                                          .w,
                                                                  child: Text(
                                                                    state
                                                                        .teacher
                                                                        .workingDays[
                                                                            index1]
                                                                        .workingTimes[
                                                                            index2]
                                                                        .first,
                                                                    style: TextStyle(
                                                                        fontSize: 20
                                                                            .sp,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                ),
                                                              )),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "To",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                state
                                                    .teacher.workingDays.length,
                                                (index1) => Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Column(
                                                        children: state
                                                                .teacher
                                                                .workingDays[
                                                                    index1]
                                                                .workingTimes
                                                                .isEmpty
                                                            ? []
                                                            : List.generate(
                                                                state
                                                                    .teacher
                                                                    .workingDays[
                                                                        index1]
                                                                    .workingTimes
                                                                    .length,
                                                                (index2) =>
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                              6.0)
                                                                          .w,
                                                                  child: Text(
                                                                    state
                                                                        .teacher
                                                                        .workingDays[
                                                                            index1]
                                                                        .workingTimes[
                                                                            index2]
                                                                        .end,
                                                                    style: TextStyle(
                                                                        fontSize: 20
                                                                            .sp,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                ),
                                                              )),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.black26, width: 20.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10).w,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // runAlignment: WrapAlignment.center,
                                    // direction: Axis.vertical,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20).w,
                                          child: Text(
                                            "Teaching description: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(

                                            constraints:
                                                BoxConstraints(maxWidth: 800.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Text(
                                              state
                                                          .teacher
                                                          .info
                                                          .teachingDescription
                                                          .length <
                                                      250
                                                  ? state.teacher.info
                                                      .teachingDescription
                                                  : state.teacher.info
                                                      .teachingDescription
                                                      .substring(
                                                          0,
                                                          _isExpandedTeaching
                                                              ? null
                                                              : 250),
                                              style: TextStyle(fontSize: 18.sp),
                                            )),
                                      ),
                                      if (state.teacher.info.teachingDescription
                                              .length >
                                          250)
                                        Padding(
                                          padding: const EdgeInsets.all(20.0).w,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isExpandedTeaching =
                                                    !_isExpandedTeaching;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  _isExpandedTeaching
                                                      ? 'see less'
                                                      : 'see more',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp),
                                                ),
                                                _isExpandedTeaching
                                                    ? Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        color: Colors.blue,
                                                        size: 15.w,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .keyboard_double_arrow_down,
                                                        color: Colors.blue,
                                                        size: 15.w,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: 30.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20).w,
                                          child: Text(
                                            "Video about me: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                      state.teacher.info.video.contains("youtube.com")?DisplayVideoYoutube(videoUrl: state.teacher.info.video):
                                      DisplayVideo(
                                          videoUrl: state.teacher.info.video),
                                      SizedBox(height: 30.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20).w,
                                          child: Text(
                                            "Available times: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 600.h,
                                        width: 600.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            color: Colors.blue.shade50),
                                        child: TableCalendar(
                                          firstDay: DateTime.utc(2010, 10, 20),
                                          lastDay: DateTime.utc(2040, 10, 20),
                                          focusedDay: _focusedDay,
                                          calendarFormat: _calendarFormat,
                                          selectedDayPredicate: (day) {

                                            return isSameDay(_selectedDay, day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            if (!isSameDay(
                                                _selectedDay, selectedDay)) {
                                              // Call `setState()` when updating the selected day
                                              setState(() {
                                                _selectedIndex = null;
                                                _selectedDay = selectedDay;
                                                _focusedDay = focusedDay;
                                              });
                                            }
                                          },
                                          onFormatChanged: (format) {
                                            if (_calendarFormat != format) {
                                              // Call `setState()` when updating calendar format
                                              setState(() {
                                                _calendarFormat = format;
                                              });
                                            }
                                          },
                                          onPageChanged: (focusedDay) {
                                            // No need to call `setState()` here
                                            _focusedDay = focusedDay;
                                          },
                                          calendarStyle: CalendarStyle(
                                              selectedDecoration:
                                                  const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              defaultTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              selectedTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              todayTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              disabledTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              holidayTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              outsideTextStyle: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.black26),
                                              rangeEndTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              rangeStartTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              weekendTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              weekNumberTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              withinRangeTextStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              outsideDaysVisible: true),
                                          daysOfWeekHeight: 40.h,
                                          daysOfWeekStyle: DaysOfWeekStyle(
                                              weekdayStyle:
                                                  TextStyle(fontSize: 20.sp),
                                              weekendStyle:
                                                  TextStyle(fontSize: 20.sp)),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10).w,
                                        constraints: BoxConstraints(maxWidth: 600.w),
                                        child: (state.teacher.availableTimes![_selectedDay.toIso8601String().split('T')[0]]?.isEmpty ?? true)
                                            ? Padding(
                                              padding: const EdgeInsets.all(8.0).w,
                                              child: Text("There arn't any available time now, try with new day.",style: TextStyle(fontSize: 20.sp,color: Colors.black87),),
                                            )
                                            : Wrap(
                                          direction: Axis.horizontal,
                                          children: (state.teacher.availableTimes![_selectedDay.toIso8601String().split('T')[0]] ?? [])
                                              .asMap()
                                              .entries
                                              .map(
                                                (entry) {
                                                return   AvailableTime(
                                                    hour: entry.value,
                                                    isSelected: _selectedIndex ==
                                                        entry.key,
                                                    onTap: () {
                                                      setState(() {
                                                        hourBooking=entry.value;
                                                        _selectedIndex =
                                                            entry.key;
                                                      });
                                                    },
                                                  );
                                                }
                                          )
                                              .toList(),
                                        ),
                                      ),


                                      Container(
                                        padding: const EdgeInsets.all(20).w,
                                        constraints:
                                            BoxConstraints(maxWidth: 600.w),
                                        child: MyElevatedButton(
                                          color: _selectedIndex == null
                                              ? [
                                                  Colors.black26,
                                                  Colors.black26,
                                                  Colors.black26,
                                                ]
                                              : const [
                                                  Color(0xff16d9e3),
                                                  Color(0xff30c7ec),
                                                  Color(0xff46aef7)
                                                ],
                                          onPressed: _selectedIndex == null
                                              ? null
                                             : () {

                                            showAppointmentDialog(context,hourBooking,_selectedDay.toIso8601String().split('T')[0]);
                                                },
                                          child: Text(
                                            "Book",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25.sp),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      footer(context),
                    ],
                  ),
                ));
          } else if (state is GetTeacherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }
  void showAppointmentDialog(BuildContext context,String hour,String date) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        BlocProvider.of<LevelBloc>(context).add(GetAllLevelsEvent());
        BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
        BlocProvider.of<GetGoalsBloc>(context).add(GetAllGoals());
        return  Dialog(
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child:  MakeAppointment(hour: hour,date: date,teacherId: widget.teacherId.toString(),)),


        );
      },
    );
  }

}

