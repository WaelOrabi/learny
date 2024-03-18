import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/appointment/presentation/bloc/accept_or_reject_appointment/accept_or_reject_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_teacher_appointment/get_teacher_appointment_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../../core/widgets/toast_widget.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/pdf_viewer.dart';
import '../../../teachers/presentation/widgets/request_details_widgets/information_text_widget.dart';
import '../../domain/entities/get_teacher_appointment_entity.dart';
import '../bloc/get_teacher_appointments_bloc/get_teacher_appointments_bloc.dart';
class TeacherAppointmentPage extends StatefulWidget {

  final int appointmentId;
  const TeacherAppointmentPage({super.key,  required this.appointmentId});

  @override
  State<TeacherAppointmentPage> createState() => _TeacherAppointmentPageState();
}

class _TeacherAppointmentPageState extends State<TeacherAppointmentPage> {
  late GetTeacherAppointmentEntity getTeacherAppointmentEntity;

  late DataEntity appointment;

  ScrollController scroll = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetTeacherAppointmentBloc>(context).add(GetTeacherAppointment(idAppointment: widget.appointmentId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_buildBody(context),
    );
  }

  BlocBuilder _buildBody(BuildContext context) {
    return BlocBuilder<GetTeacherAppointmentBloc, GetTeacherAppointmentState>(
      builder: (context, state) {
        if (state is GetTeacherAppointmentLoaded) {
          getTeacherAppointmentEntity=state.getTeacherAppointmentEntity;
          appointment=getTeacherAppointmentEntity.data;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPersonalInformation(context, appointment.student),
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
            SizedBox(height:100),
            appointment.appointmentStatus=="waiting"?
            _acceptOrRejectButtons(context, appointmentId: widget.appointmentId):Container(),
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
BlocConsumer<AcceptOrRejectAppointmentBloc, AcceptOrRejectAppointmentState>
_acceptOrRejectButtons(BuildContext context, {required appointmentId}) {
  return BlocConsumer<AcceptOrRejectAppointmentBloc, AcceptOrRejectAppointmentState>(
    listener: (context,state){
      if(state is AcceptAppointmentState ) {
        showToastWidgetSuccess('Appointment accepted');
        BlocProvider.of<GetTeacherAppointmentsBloc>(context).add(
            GetTeacherAppointments(
                statuses: BlocProvider.of<GetTeacherAppointmentsBloc>(context).list,
                pageNumber: 1));
        Navigator.of(context).pop();
      }
      else if(state is RejectAppointmentState){
        showToastWidgetError('Appointment declined');
        BlocProvider.of<GetTeacherAppointmentsBloc>(context).add(
            GetTeacherAppointments(
                statuses: BlocProvider.of<GetTeacherAppointmentsBloc>(context).list,
                pageNumber: 1));
        Navigator.of(context).pop();
      }
    },
    builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyElevatedButton(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height *
                Constants.heightElevatedButton,
            onPressed: () {
              BlocProvider.of<AcceptOrRejectAppointmentBloc>(context).add(
                  AcceptAppointment(appointmentId:appointmentId, statusId:3));
            },
            child: state is AcceptRequestLoadingState
                ? const  CircularProgressIndicator(
              color: Colors.white,
            )
                : Text(
              'Accept',
              style: MyAppTheme.myTheme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          MyElevatedButton(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height *
                Constants.heightElevatedButton,
            color: const [Colors.red, Colors.redAccent],
            onPressed: () {
              BlocProvider.of<AcceptOrRejectAppointmentBloc>(context).add(
                  RejectAppointment(statusId: 2, appointmentId: appointmentId));
            },
            child: state is RejectRequestLoadingState
                ? const CircularProgressIndicator(
              color: Colors.white,
            )
                : Text(
              'Reject',
              style: MyAppTheme.myTheme.textTheme.headlineMedium,
            ),
          ),
        ],
      );
    },
  );
}



Padding _buildPersonalInformation(
    BuildContext context, UserEntity studentInformation) {
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
            child: studentInformation.personalImage !=
                null
                ? CircleAvatar(
              foregroundImage: NetworkImage(
                studentInformation.personalImage!,
              ),
              radius: 70,
            )
                : ProfilePicture(
              name:
              "${studentInformation.firstName} ${studentInformation.lastName}",
              radius: 70.w,
              fontsize: 30.sp,
              random: true,
            ),
          ),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Name: ',
              value:
              '  ${studentInformation.firstName} ${studentInformation.lastName}'),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Email: ',
              value:
              studentInformation.email),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Phone number: ',
              value:
              studentInformation.phoneNumber),
          const SizedBox(height:10,),
          InformationTextWidget(
              text: 'Nationality: ',
              value:
              '  ${studentInformation.nationality!.name}'),

        ],
      ),
    ),
  );
}

