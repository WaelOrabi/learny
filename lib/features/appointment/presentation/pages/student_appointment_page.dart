import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:learny_project/features/appointment/presentation/bloc/booking_appointment_bloc/booking_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_student_appointment_bloc/get_student_appointment_bloc.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../../core/constants.dart';
import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/pdf_viewer.dart';
import '../../../teachers/presentation/widgets/request_details_widgets/information_text_widget.dart';
import 'make_appointment.dart';
class GetStudentAppointmentPage extends StatefulWidget {

  final int appointmentId;
  const GetStudentAppointmentPage({super.key,  required this.appointmentId});

  @override
  State<GetStudentAppointmentPage> createState() => _GetStudentAppointmentPageState();
}

class _GetStudentAppointmentPageState extends State<GetStudentAppointmentPage> {
  late GetStudentAppointmentEntity getStudentAppointmentEntity;

  late DataEntity appointment;

  ScrollController scroll = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetStudentAppointmentBloc>(context).add(GetStudentAppointment(idAppointment: widget.appointmentId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_buildBody(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return Dialog(
      //             child: SizedBox(
      //               height: MediaQuery.of(context).size.height * 0.9,
      //               width: MediaQuery.of(context).size.width * 0.8,
      //               child: MakeAppointment(getStudentAppointmentEntity: getStudentAppointmentEntity,),
      //             ),
      //           );
      //         }
      //     );
      //   },
      //   child:const Icon(Icons.edit),
      // ),

    );
  }

  BlocBuilder _buildBody(BuildContext context) {
    return BlocBuilder<GetStudentAppointmentBloc, GetStudentAppointmentState>(
      builder: (context, state) {
        if (state is GetStudentAppointmentLoaded) {
          getStudentAppointmentEntity=state.getStudentAppointmentEntity;
          appointment=getStudentAppointmentEntity.data;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPersonalInformation(context, appointment.teacher),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,left: 50),
                      child: Container(
                        color: Constants.primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:  appointment.files.map((e)
                                {

                                  if(e.filePath.contains('pdf')) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(left: 20, bottom: 20),
                                      child: PdfViewer(
                                        url: e.filePath,
                                        width: 800.w,
                                        height: 400.h,
                                      ),
                                    );
                                  } else {
                                    return Image(
                                  image: NetworkImage(e.filePath,

                                  ),
                                        width: 700.w,
                                        height: 500.h,
                                        fit: BoxFit.fill,
                                  );
                                  }
                                        }).toList(),
                              ),
                            ),
                         const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Description: ',
                                value:
                                '  ${appointment.description}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Date: ',
                                value:
                                '  ${appointment.date}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Time: ',
                                value:
                                '  ${appointment.time}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Appointment State : ',
                                value:
                                '  ${appointment.appointmentStatus}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Language : ',
                                value:
                                '  ${appointment.language}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'The goal of a lesson : ',
                                value:
                                '  ${appointment.studentGoal.goalName}'),
                            const  SizedBox(height: 10,),
                            InformationTextWidget(
                                text: 'Level : ',
                                value:
                                '  ${appointment.studentLevel.levelName}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Constants.secondaryColor,
          ),
        );
      },
    );
  }
}

Padding _buildPersonalInformation(
    BuildContext context, TeacherEntity teacherInformation) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Container(
      color: Constants.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: teacherInformation.userInfo.personalImage !=
                null
                ? CircleAvatar(
              foregroundImage: NetworkImage(
                teacherInformation.userInfo.personalImage!,
              ),
              radius: 70,
            )
                : ProfilePicture(
              name:
              "${teacherInformation.userInfo.firstName} ${teacherInformation.userInfo.lastName}",
              radius: 70.w,
              fontsize: 30.sp,
              random: true,
            ),
          ),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Name: ',
              value:
              '  ${teacherInformation.userInfo.firstName} ${teacherInformation.userInfo.lastName}'),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Email: ',
              value:
              teacherInformation.userInfo.email),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Phone number: ',
              value:
              teacherInformation.userInfo.phoneNumber),
          const SizedBox(height:10,),
          Row(
            children: [
              InformationTextWidget(
                  text: 'Rating: ',
                  value:
                  teacherInformation.rating.toStringAsFixed(2)),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow.shade600,
                  size: 30.w,
                ),
              )
            ],
          ),
          InformationTextWidget(
              text: 'Nationality: ',
              value:
              '  ${teacherInformation.userInfo.nationality!.name}'),

        ],
      ),
    ),
  );
}

