part of 'teacher_request_details_bloc.dart';
@immutable
abstract class TeacherRequestDetailsState{}
class TeacherRequestDetailsInitialState extends TeacherRequestDetailsState{}
class TeacherRequestDetailsLoadingState extends TeacherRequestDetailsState{}
class TeacherRequestDetailsLoadedState extends TeacherRequestDetailsState{
 final TeacherRequestDetailsEntity teacherRequestDetailsModel;

  TeacherRequestDetailsLoadedState({required this.teacherRequestDetailsModel});
}
class TeacherRequestDetailsFailState extends TeacherRequestDetailsState{
  final List<String?> message;

  TeacherRequestDetailsFailState({required this.message});

}
