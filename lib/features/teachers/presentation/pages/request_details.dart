import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:learny_project/core/widgets/toast_widget.dart';
import '../bloc/accept_or_reject_request/accept_or_reject_request_bloc.dart';
import '../widgets/becom_a_teacher_widgets/pdf_viewer.dart';
import '../widgets/request_details_widgets/display_video.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../bloc/teacher_request_details/teacher_request_details_bloc.dart';
import '../widgets/request_details_widgets/expandable_text_widget.dart';
import '../widgets/request_details_widgets/image_card_widget.dart';
import '../widgets/request_details_widgets/information_text_widget.dart';
import 'package:learny_project/features/teachers/presentation/bloc/teachers_requests/teachers_requests_bloc.dart';

import '../widgets/show_details_teacher/display_video_youtube.dart';

class TeacherRequestDetails extends StatelessWidget {
  TeacherRequestDetails({Key? key, required this.status}) : super(key: key);
  final String status;

  VideoPlayerController? _controller;

  ScrollController scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AcceptOrRejectRequestBloc, AcceptOrRejectRequestState>(
        listener: (context, state) {
          if (state is AcceptTeacherRequestState ) {
         showToastWidgetSuccess('Request accepted');
         BlocProvider.of<TeachersRequestsBloc>(context)
             .add(GetAllTeachersRequestsEvent(statuses: const ['3']));
         WidgetsBinding.instance.addPostFrameCallback((_) {
           Navigator.of(context).pop();
         });
          }else if(
          state is RejectTeacherRequestState){
            showToastWidgetError('Request delete');
            BlocProvider.of<TeachersRequestsBloc>(context)
                .add(GetAllTeachersRequestsEvent(statuses: const ['3']));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  BlocBuilder _buildBody(BuildContext context) {
    return BlocBuilder<TeacherRequestDetailsBloc, TeacherRequestDetailsState>(
      builder: (context, state) {
        if (state is TeacherRequestDetailsLoadedState) {
          _controller ??= VideoPlayerController.network(
              state.teacherRequestDetailsModel.info.video);

          return SingleChildScrollView(
            controller: scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),
                Padding(
                  padding: const EdgeInsets.only(top: 20).h,
                  child: Center(child: Text("${state.teacherRequestDetailsModel.userInfo.firstName} ${state.teacherRequestDetailsModel.userInfo.lastName}",style: TextStyle(color: Colors.blue,fontSize: 40.sp,fontWeight: FontWeight.bold),),),
                ),
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPersonalInformation(context, state),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                        child: Container(
                          color: Constants.primaryColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, top: 20),
                                child: Text(
                                  'image Card:',
                                  style: TextStyle(
                                      color: MyAppTheme
                                          .myTheme.textTheme.titleMedium!.color,
                                      fontSize: MyAppTheme.myTheme.textTheme
                                          .titleMedium!.fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _informationCard(state),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, top: 20, bottom: 10),
                                child: Text(
                                  'Languages:',
                                  style: TextStyle(
                                      color: MyAppTheme
                                          .myTheme.textTheme.titleMedium!.color,
                                      fontSize: MyAppTheme.myTheme.textTheme
                                          .titleMedium!.fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _informationLanguagesAndCertificates(
                                  context, state),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Video about teacher:',
                    style: MyAppTheme.myTheme.textTheme.titleMedium,
                  ),
                ),

                state.teacherRequestDetailsModel.info.video.contains("youtube.com")?DisplayVideoYoutube(videoUrl: state.teacherRequestDetailsModel.info.video):
                DisplayVideo(
                    videoUrl: state.teacherRequestDetailsModel.info.video),
                const SizedBox(
                  height: 100,
                ),
                status == "Pending"
                    ? _acceptOrRejectButtons(context,
                        teacherId: state.teacherRequestDetailsModel.teacherId)
                    : Container(),
                const SizedBox(
                  height: 50,
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

  BlocBuilder<AcceptOrRejectRequestBloc, AcceptOrRejectRequestState>
      _acceptOrRejectButtons(BuildContext context, {required teacherId}) {
    return BlocBuilder<AcceptOrRejectRequestBloc, AcceptOrRejectRequestState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyElevatedButton(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height *
                  Constants.heightElevatedButton,
              onPressed: () {
                BlocProvider.of<AcceptOrRejectRequestBloc>(context).add(
                    AcceptTeacherRequestEvent(
                        status: '1', teacherId: teacherId.toString()));
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
              width: 20,
            ),
            MyElevatedButton(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height *
                  Constants.heightElevatedButton,
              color: const [Colors.red, Colors.redAccent],
              onPressed: () {
                BlocProvider.of<AcceptOrRejectRequestBloc>(context).add(
                    RejectTeacherRequestEvent(
                        status: '2', teacherId: teacherId.toString()));
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

  Padding _informationCard(TeacherRequestDetailsLoadedState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 100, top: 20),
      child: Row(
        children: [
          ImageCardWidget(
              image: state.teacherRequestDetailsModel.cardId.frontCardImage,
              heightImage: 200,
              widthImage: 300),
          const SizedBox(
            width: 50,
          ),
          ImageCardWidget(
              image: state.teacherRequestDetailsModel.cardId.backCardImage,
              heightImage: 200,
              widthImage: 300),
        ],
      ),
    );
  }

  SizedBox _informationLanguagesAndCertificates(
      BuildContext context, TeacherRequestDetailsLoadedState state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.teacherRequestDetailsModel.languages.length,
          itemBuilder: (context, indexLanguage) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InformationTextWidget(
                    text: 'Language: ',
                    value:
                        ' ${state.teacherRequestDetailsModel.languages[indexLanguage].language}'),
                InformationTextWidget(
                    text: 'Level: ',
                    value:
                        ' ${state.teacherRequestDetailsModel.languages[indexLanguage].level}'),
                InformationTextWidget(
                    text: 'Years of experience:  ',
                    value:
                        ' ${state.teacherRequestDetailsModel.languages[indexLanguage].yearsOfExperience}'),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Certificates: \n',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MyAppTheme.myTheme.textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.teacherRequestDetailsModel
                          .languages[indexLanguage].certificates!.length,
                      itemBuilder: (context, indexCertificate) {

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InformationTextWidget(
                                text: 'Type: ',
                                value:
                                    ' ${state.teacherRequestDetailsModel.languages[indexLanguage].certificates![indexCertificate].certificateType}'),
                            const SizedBox(
                              height: 20,
                            ),
                            InformationTextWidget(
                                text: 'Downer Name: ',
                                value:
                                    ' ${state.teacherRequestDetailsModel.languages[indexLanguage].certificates![indexCertificate].doner.donerName}'),
                            const SizedBox(
                              height: 20,
                            ),
                            InformationTextWidget(
                                text: 'Downer Type: ',
                                value:
                                    ' ${state.teacherRequestDetailsModel.languages[indexLanguage].certificates![indexCertificate].doner.donerType}'),
                            const SizedBox(
                              height: 20,
                            ),
                            const InformationTextWidget(
                                text: 'Image: ', value: ''),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: state
                                  .teacherRequestDetailsModel
                                  .languages[indexLanguage]
                            .certificates[indexCertificate]
                            .certificateImage.contains('pdf')? PdfViewer(
                                url: state
                                    .teacherRequestDetailsModel
                                    .languages[indexLanguage]
                                    .certificates[indexCertificate]
                                    .certificateImage,
                                width: 800.w,
                                height: 400.h,
                              ):Image.network( state
                                  .teacherRequestDetailsModel
                                  .languages[indexLanguage]
                                  .certificates[indexCertificate]
                                  .certificateImage,
                                width: 800.w,
                                height: 400.h,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'About: \n',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MyAppTheme.myTheme.textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ExpandableText(
                    text: state.teacherRequestDetailsModel.info.about,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Description of teaching: \n',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MyAppTheme.myTheme.textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ExpandableText(
                    text: state
                        .teacherRequestDetailsModel.info.teachingDescription,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ],
            );
          }),
    );
  }

  Padding _buildPersonalInformation(
      BuildContext context, TeacherRequestDetailsLoadedState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        color: Constants.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: state.teacherRequestDetailsModel.userInfo.personalImage !=
                      null
                  ? CircleAvatar(
                      foregroundImage: NetworkImage(
                        state
                            .teacherRequestDetailsModel.userInfo.personalImage!,
                      ),
                      radius: 70,
                    )
                  : CircleAvatar(
                foregroundImage: NetworkImage(
                  "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIEAdQMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAABAUGAwECB//EADQQAAICAQEGAgcHBQAAAAAAAAABAgMEEQUhMUFRcRIiEzJhkbHB0SNCUmKC4fAUM3KBof/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/ZQAAAAAAAAAAAAAAAAAAAAAAAAAAB8X2woqdlj0ijP5ufblSa1ca+UVz7lF1btDFqekrot9I+b4HNbVxG/Xkv0MzwLErVU31Xr7GyM/Ynv9x0MlFuLTi2muDRcbO2m5yVOS9ZPdGfX2MkFqACKAAAAAAAAABvRa9AKHbGS7ch1Rfkr3d3z+hXnspOcnJ8ZPVnhpAABAABWi2VkvIxl43rOHlft6MmFJsKemTZDlKGvuf7l2ZUAAAAAAAADWqa6gAZJxcW4vitzPCftfGdOS7EvJZv8A98yAaQAAQAAVZbCi3lTnyjDT3v8AYvCFsnGdGN4pLSdm969ORNM6uAAAAAAAAAAbUU3J6JcWwOeRTDIqlXYtYv3p9TPZmFbiS861hymluZaZG16a5eGqMrerT0RNpthk0qyG+ElwfwZUZUGjt2ZiWPX0fhf5HoclsfGT3u1/qX0LSKHtxLbZuzJeJXZMdEt8YPn3LKjEox99Vai+vFnHO2hDElGHhc5ve0npoiCYCNiZ1GVuhJxn+CXEkkUAAAAAADyUlCLlJpRitW3yA+b7oUVuy16RX/exns3Osy5aPy1p7oJ/HqeZ+XLLub3qtboR+ZGLiBKwc2zEm9PNW/Wj8+5FBRpaM/GuW62MX+GW5naV1UVq7a0vbJGUBIVe5e1qq14cf7SfX7q+pSWTlZOU5ycpSerb5nyCwFuaa5Fxs7aerVOTLfwjN/MpwBrgVex812L+ntfmS8j6roWhlQAACp25ktKOPB8fNPtyRbNqMXJ8FvZlci133zsf3nr2LhrmACsgAAAAAAAAAA9hOVc4zg9JReqZqMW9ZFELVzW9dHzMsWuwrtJ2UPg/Mu/P+ewkVcgAiou1LPR4NunGS8PvM2Xu3npi1pc7PkyiNYgAAgAAAAAAAAAAB3wbPRZlMvzJPs9xwGum9cgrXng113gyqt27/Zp/zfwKpcEAaxAABAAAAAAAAAAAD5s9R9gBqtRH1V2ABlX/2Q==",
                ),
                radius: 70,
              ),
            ),
            InformationTextWidget(
                text: 'Name: ',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.firstName} ${state.teacherRequestDetailsModel.userInfo.lastName}'),
            InformationTextWidget(
                text: 'Email: ',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.firstName} ${state.teacherRequestDetailsModel.userInfo.email}'),
            InformationTextWidget(
                text: 'Phone number:',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.phoneNumber}'),
            InformationTextWidget(
                text: 'ID card:',
                value:
                    '  ${state.teacherRequestDetailsModel.cardId.nationalNumber}'),
            InformationTextWidget(
                text: 'Gender:',
                value: '  ${state.teacherRequestDetailsModel.userInfo.gender}'),
            InformationTextWidget(
                text: 'Birth Date:',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.birthDate}'),
            InformationTextWidget(
                text: 'Nationality: ',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.nationality!.name}'),
            InformationTextWidget(
                text: 'Gender:',
                value: '  ${state.teacherRequestDetailsModel.userInfo.gender}'),
            InformationTextWidget(
                text: 'Birth date:',
                value:
                    '  ${state.teacherRequestDetailsModel.userInfo.birthDate}'),
            const InformationTextWidget(text: 'About me: ', value: null),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: ExpandableText(
                  text: ' ${state.teacherRequestDetailsModel.info.about}',
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
          ],
        ),
      ),
    );
  }

}
