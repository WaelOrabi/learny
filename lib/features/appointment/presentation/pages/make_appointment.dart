import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learny_project/features/appointment/domain/entities/get_goals_entity.dart';
import 'package:learny_project/features/appointment/presentation/bloc/booking_appointment_bloc/booking_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/pages/student_appointments_page.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../../core/widgets/custom_dropdown_button_widget.dart';

import '../../../../core/widgets/toast_widget.dart';
import '../../../admin/domain/entities/language_entity.dart';
import '../../../admin/domain/entities/level_entity.dart';
import '../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../../domain/entities/attachments_entity.dart';
import '../../domain/entities/booking_appointment_entity.dart';
import '../../domain/entities/get_student_appointment_entity.dart';
import '../../domain/entities/update_booking_appointment_entity.dart';
import '../bloc/get_goals_bloc/get_goals_bloc.dart';
import '../bloc/update_booking_appointment_bloc/update_booking_appointment_bloc.dart';
import '../widgets/attachment_widget.dart';

class MakeAppointment extends StatefulWidget {
  String? hour;
  String? date;
  String? teacherId;
  final GetStudentAppointmentEntity? getStudentAppointmentEntity;

  MakeAppointment(
      {Key? key,
      this.hour,
      this.date,
      this.teacherId,
      this.getStudentAppointmentEntity})
      : super(key: key);

  @override
  MakeAppointmentState createState() => MakeAppointmentState();
}

class MakeAppointmentState extends State<MakeAppointment> {
  String? _selectedLevel;
  String? _selectedGoal;
  String? _selectedLanguage;
  final TextEditingController _descriptionController = TextEditingController();
  bool isImage = true;
  String url1 = '';
  String base64 = '';
  XFile? imageAttachmentFile;
  String? imageAttachment;
  bool isAddingSecondAttachment = false;
  late GoalsEntity goalsEntity;
  late List<Level> levels;
  late List<Language> languages;
  late String languageId;
  late String levelId;
  late String goalId;
  List<String> files = [];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<AttachmentsEntity> list =
        BlocProvider.of<BookingAppointmentBloc>(context).attachments;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              'Booking Appointment',
              style: MyAppTheme.myTheme.textTheme.displayLarge,
            ),
            const SizedBox(height: 50),
            //  Attachments(),
            BlocBuilder<BookingAppointmentBloc, BookingAppointmentState>(
              builder: (context, state) {
                if (state is DeleteAttachmentsState) {
                  list = state.attachments;
                } else if (state is AddAttachmentsState) {
                  list = state.attachments;
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        list.length,
                        (index) => Row(
                              children: [
                                AttachmentWidget(
                                  index: list[index].index,
                                  path: list[index].path!,
                                ),
                                Column(
                                  children: [
                                    if (list.length > 1)
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<
                                                        BookingAppointmentBloc>(
                                                    context)
                                                .add(DeleteAttachments(
                                                    attachmentsId:
                                                        list[index].index));
                                          },
                                          icon: Icon(Icons.remove)),
                                    IconButton(
                                        onPressed: () {
                                          final newAttachment = AttachmentsEntity(
                                              index: BlocProvider.of<
                                                          BookingAppointmentBloc>(
                                                      context)
                                                  .attachments
                                                  .length,
                                              path: '');
                                          BlocProvider.of<
                                                      BookingAppointmentBloc>(
                                                  context)
                                              .add(AddAttachments(
                                                  attachments: newAttachment));
                                        },
                                        icon: Icon(Icons.add)),
                                  ],
                                )
                              ],
                            )),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            BlocBuilder<LevelBloc, LevelState>(
              builder: (context, state) {
                List<String> levelsNames = [];
                if (state is GetAllLevelsSuccessState) {
                  levels = state.listAllLevels;
                  for (int i = 0; i < state.listAllLevels.length; i++) {
                    levelsNames.add(state.listAllLevels[i].levelName);
                  }
                }
                return _buildDropdownRow(
                  distanceInWidth: 190,
                  label: 'Level:',
                  items: levelsNames.isNotEmpty
                      ? levelsNames
                      : const [
                          'A1',
                          'A2',
                          'B1',
                        ],
                  selectedValue: _selectedLevel,
                  hint: 'Select level',
                  onChanged: (value) => setState(() => _selectedLevel = value),
                );
              },
            ),
            const SizedBox(height: 30),
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                List<String> languagesNames = [];
                if (state is GetAllLanguagesSuccessState) {
                  languages = state.listAllLanguages;
                  for (int i = 0; i < state.listAllLanguages.length; i++) {
                    languagesNames.add(state.listAllLanguages[i].languageName);
                  }
                }
                return _buildDropdownRow(
                  distanceInWidth: 145,
                  label: 'Language:',
                  items:
                      languagesNames.isNotEmpty ? languagesNames : const [''],
                  selectedValue: _selectedLanguage,
                  hint: 'Select language',
                  onChanged: (value) =>
                      setState(() => _selectedLanguage = value),
                );
              },
            ),
            const SizedBox(height: 30),
            BlocBuilder<GetGoalsBloc, GetGoalsState>(
              builder: (context, state) {
                List<String> goals = [];
                if (state is GetAllGoalsState) {
                  goalsEntity = state.goalsEntity;
                  for (int i = 0; i < state.goalsEntity.data.length; i++) {
                    goals.add(state.goalsEntity.data[i].goalName);
                  }
                }
                return _buildDropdownRow(
                  distanceInWidth: 195,
                  label: 'Goal:',
                  items: goals.isNotEmpty ? goals : const [''],
                  selectedValue: _selectedGoal,
                  hint: 'Select goal',
                  onChanged: (value) => setState(() => _selectedGoal = value),
                );
              },
            ),
            const SizedBox(height: 30),
            _buildDescriptionRow(),
            const SizedBox(height: 30),
            BlocConsumer<BookingAppointmentBloc, BookingAppointmentState>(
              listener: (context,state)async{
                if(state is BookingAppointmentLoaded) {
                  showToastWidgetSuccess('The appointment has been successfully booked');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const StudentAppointmentsPage()));
                }else if(state is BookingAppointmentError)
                  {
                    for(int i=0;i<state.message.length;i++)
                      {
                         showToastWidgetError(state.message[i]);
                        await Future.delayed(const Duration(seconds: 4));
                      }
                  }
              },
              builder: (context, state) {
                return MyElevatedButton(
                  width: 200.w,
                  height: 60.h,
                  onPressed: () {
                    for (int i = 0;
                        i <
                            BlocProvider.of<BookingAppointmentBloc>(context)
                                .attachments
                                .length;
                        i++) {
                      files.add(BlocProvider.of<BookingAppointmentBloc>(context)
                          .attachments[i]
                          .path!);
                    }

                    languages.map((language) {
                      if (language.languageName == _selectedLanguage) {
                        languageId = language.languageId;
                      }
                    }).toList();
                    levels.map((level) {
                      if (level.levelName == _selectedLevel) {
                        levelId = level.levelId;
                      }
                    }).toList();
                    goalsEntity.data.map((goal) {
                      if (goal.goalName == _selectedGoal) {
                        goalId = goal.id.toString();
                      }
                    }).toList();

                    BlocProvider.of<BookingAppointmentBloc>(context).add(
                        BookingAppointment(
                            bookingAppointmentEntity: BookingAppointmentEntity(
                                languageId: languageId,
                                periodId: '1',
                                teacherId: widget.teacherId!,
                                levelId: levelId,
                                goalId: goalId,
                                date: widget.date!,
                                time: widget.hour!,
                                description: _descriptionController.text,
                                files: files)));
                  },
                  child: state is BookingAppointmentLoading
                      ?  const Center(
                    child: CircularProgressIndicator(),
                ):Text(
                          "Submit",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),

                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required List<String> items,
    required String? selectedValue,
    required String hint,
    required double distanceInWidth,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: distanceInWidth),
        DropdownButtonHideUnderline(
          child: CustomDropdownButtonWidget(
            items: items,
            value: selectedValue,
            hintText: hint,
            onChanged: onChanged,
            widthForm: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Description:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(width: 130),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5.w,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please this field is required';
              } else if (value.length < 10) {
                return 'You must enter at least 10 characters';
              }
            },
            maxLines: null,
            maxLength: 600,
            controller: _descriptionController,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            decoration: InputDecoration(
              hintMaxLines: 1,
              hintText: "Enter some details about the lesson...",
              hintStyle: MyAppTheme.myTheme.inputDecorationTheme.hintStyle,
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constants.cyanColoraec6cf),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constants.cyanColoraec6cf),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
