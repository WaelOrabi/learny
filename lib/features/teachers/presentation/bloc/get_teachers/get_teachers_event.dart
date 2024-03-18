part of 'get_teachers_bloc.dart';

@immutable
abstract class GetTeachersEvent {}
class GetTeachers extends GetTeachersEvent{
   List<String>languages;
   int page;

  GetTeachers({required this.languages,required this.page});
}