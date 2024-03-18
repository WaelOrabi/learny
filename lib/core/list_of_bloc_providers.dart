import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/booking_appointment_bloc/booking_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/delete_appointment_bloc/delete_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_goals_bloc/get_goals_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_student_appointment_bloc/get_student_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_teacher_appointment/get_teacher_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/update_booking_appointment_bloc/update_booking_appointment_bloc.dart';
import 'package:learny_project/features/home/presentation/bloc/info_home_bloc/info_home_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/paragraphs/paragraphs_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/posts/posts_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/questions/questions_bloc.dart';
import 'package:learny_project/features/teachers/presentation/bloc/get_teacher/get_teacher_bloc.dart';
import 'package:learny_project/features/teachers/presentation/bloc/get_teachers/get_teachers_bloc.dart';
import '../features/admin/presentation/bloc/certificate_type_bloc/certificate_type_bloc.dart';
import '../features/admin/presentation/bloc/country_bloc/country_bloc.dart';
import '../features/admin/presentation/bloc/donor_type_bloc/donor_type_bloc.dart';
import '../features/admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../features/admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../features/appointment/presentation/bloc/accept_or_reject_appointment/accept_or_reject_appointment_bloc.dart';
import '../features/appointment/presentation/bloc/get_goals_bloc/get_goals_bloc.dart';
import '../features/appointment/presentation/bloc/get_student_appointments_bloc/get_student_appointments_bloc.dart';
import '../features/appointment/presentation/bloc/get_teacher_appointments_bloc/get_teacher_appointments_bloc.dart';
import '../features/home/presentation/bloc/get_best_teachers_bloc/get_best_teachers_bloc.dart';
import '../features/home/presentation/bloc/packages_hours_price_bloc/packages_hours_price_bloc.dart';
import '../features/home/presentation/bloc/services_bloc/services_bloc.dart';
import '../features/content/presentation/bloc/content/content_bloc.dart';
import '../features/teachers/presentation/bloc/accept_or_reject_request/accept_or_reject_request_bloc.dart';
import '../features/teachers/presentation/bloc/become_a_teacher/become_a_teacher_bloc.dart';
import '../features/teachers/presentation/bloc/teacher_request_details/teacher_request_details_bloc.dart';
import '../features/teachers/presentation/bloc/teachers_requests/teachers_requests_bloc.dart';
import '../features/working_times/presentation/bloc/working_times_bloc.dart';
import '../features/auth/presentation/bloc/change_password/change_password_bloc.dart';
import '../features/auth/presentation/bloc/check_otp/check_otp_bloc.dart';
import '../features/auth/presentation/bloc/forget_password/forget_password_bloc.dart';
import '../features/auth/presentation/bloc/login/login_bloc.dart';
import '../features/auth/presentation/bloc/logout/logout_bloc.dart';
import '../features/auth/presentation/bloc/send_otp/send_otp_bloc.dart';
import '../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import '../features/auth/presentation/bloc/verify_account/verify_account_bloc.dart';
import '../injection_container.dart' as di;

List<BlocProvider> createBlocProviders() {
  return [
    BlocProvider<GetBestTeachersBloc>(create: (context)=>di.sl<GetBestTeachersBloc>()),
    BlocProvider<InfoHomeBloc>(create: (context)=>di.sl<InfoHomeBloc>()),
    BlocProvider<ServicesBloc>(create: (context)=>di.sl<ServicesBloc>()),
    BlocProvider<PackagesHoursPriceBloc>(create: (context)=>di.sl<PackagesHoursPriceBloc>()),
    BlocProvider<BookingAppointmentBloc>(create: (context)=>di.sl<BookingAppointmentBloc>()),
    BlocProvider<GetGoalsBloc>(create: (context)=>di.sl<GetGoalsBloc>()),
    BlocProvider<UpdateBookingAppointmentBloc>(create: (context)=>di.sl<UpdateBookingAppointmentBloc>()),
    BlocProvider<DeleteAppointmentBloc>(create: (context)=>di.sl<DeleteAppointmentBloc>()),
    BlocProvider<LoginBloc>(create: (context)=>di.sl<LoginBloc>()),
    BlocProvider<AcceptOrRejectRequestBloc>(create: (context)=>di.sl<AcceptOrRejectRequestBloc>(),),
    BlocProvider<TeacherRequestDetailsBloc>(create: (context)=>di.sl<TeacherRequestDetailsBloc>()),
    BlocProvider<WorkingTimesBloc>(create: (context)=>di.sl<WorkingTimesBloc>()),
    BlocProvider<ChangePasswordBloc>(create: (context)=>di.sl<ChangePasswordBloc>()),
    BlocProvider<VerifyAccountBloc>(create: (context)=>di.sl<VerifyAccountBloc>()),
    BlocProvider<ForgetPasswordBloc>(create: (context)=>di.sl<ForgetPasswordBloc>()),
    BlocProvider<SendOtpBloc>(create: (context)=>di.sl<SendOtpBloc>()),
    BlocProvider<CheckOtpBloc>(create: (context)=>di.sl<CheckOtpBloc>()),
    BlocProvider<LogoutBloc>(create: (context)=>di.sl<LogoutBloc>()),
    BlocProvider<SignUpBloc>(create: (context)=>di.sl<SignUpBloc>()),
    BlocProvider<BecomeATeacherBloc>(create: (context)=>di.sl<BecomeATeacherBloc>()),
    BlocProvider<CertificateTypeBloc>(create: (context)=>di.sl<CertificateTypeBloc>()),
    BlocProvider<CountryBloc>(create: (context)=>di.sl<CountryBloc>()),
    BlocProvider<DonorTypeBloc>(create: (context)=>di.sl<DonorTypeBloc>()),
    BlocProvider<LanguageBloc>(create: (context)=>di.sl<LanguageBloc>()),
    BlocProvider<LevelBloc>(create: (context)=>di.sl<LevelBloc>()),
    BlocProvider<TeachersRequestsBloc>(create: (context)=>di.sl<TeachersRequestsBloc>()),
    BlocProvider<GetTeachersBloc>(create: (context)=>di.sl<GetTeachersBloc>()),
    BlocProvider<GetTeacherBloc>(create: (context)=>di.sl<GetTeacherBloc>()),
    BlocProvider<BookingAppointmentBloc>(create: (context)=>di.sl<BookingAppointmentBloc>()),
    BlocProvider<UpdateBookingAppointmentBloc>(create: (context)=>di.sl<UpdateBookingAppointmentBloc>()),
  BlocProvider<DeleteAppointmentBloc>(create:(context)=>di.sl<DeleteAppointmentBloc>()),
  BlocProvider<GetStudentAppointmentBloc>(create:(context)=>di.sl<GetStudentAppointmentBloc>()),
    BlocProvider<GetStudentAppointmentsBloc>(create:(context)=>di.sl<GetStudentAppointmentsBloc>()),
    BlocProvider<GetTeacherAppointmentBloc>(create: (context)=>di.sl<GetTeacherAppointmentBloc>()),
    BlocProvider<GetTeacherAppointmentsBloc>(create: (context)=>di.sl<GetTeacherAppointmentsBloc>()),
    BlocProvider<AcceptOrRejectAppointmentBloc>(create: (context)=>di.sl<AcceptOrRejectAppointmentBloc>()),
    BlocProvider<BookingAppointmentBloc>(
        create: (context) => di.sl<BookingAppointmentBloc>()),
    BlocProvider<UpdateBookingAppointmentBloc>(
        create: (context) => di.sl<UpdateBookingAppointmentBloc>()),
    BlocProvider<DeleteAppointmentBloc>(
        create: (context) => di.sl<DeleteAppointmentBloc>()),
    BlocProvider<LoginBloc>(create: (context) => di.sl<LoginBloc>()),
    BlocProvider<AcceptOrRejectRequestBloc>(
      create: (context) => di.sl<AcceptOrRejectRequestBloc>(),
    ),
    BlocProvider<TeacherRequestDetailsBloc>(
        create: (context) => di.sl<TeacherRequestDetailsBloc>()),
    BlocProvider<WorkingTimesBloc>(
        create: (context) => di.sl<WorkingTimesBloc>()),
    BlocProvider<ChangePasswordBloc>(
        create: (context) => di.sl<ChangePasswordBloc>()),
    BlocProvider<VerifyAccountBloc>(
        create: (context) => di.sl<VerifyAccountBloc>()),
    BlocProvider<ForgetPasswordBloc>(
        create: (context) => di.sl<ForgetPasswordBloc>()),
    BlocProvider<SendOtpBloc>(create: (context) => di.sl<SendOtpBloc>()),
    BlocProvider<CheckOtpBloc>(create: (context) => di.sl<CheckOtpBloc>()),
    BlocProvider<LogoutBloc>(create: (context) => di.sl<LogoutBloc>()),
    BlocProvider<SignUpBloc>(create: (context) => di.sl<SignUpBloc>()),
    BlocProvider<BecomeATeacherBloc>(
        create: (context) => di.sl<BecomeATeacherBloc>()),
    BlocProvider<CertificateTypeBloc>(
        create: (context) => di.sl<CertificateTypeBloc>()),
    BlocProvider<CountryBloc>(create: (context) => di.sl<CountryBloc>()),
    BlocProvider<DonorTypeBloc>(create: (context) => di.sl<DonorTypeBloc>()),
    BlocProvider<LanguageBloc>(create: (context) => di.sl<LanguageBloc>()),
    BlocProvider<LevelBloc>(create: (context) => di.sl<LevelBloc>()),
    BlocProvider<TeachersRequestsBloc>(
        create: (context) => di.sl<TeachersRequestsBloc>()),
    BlocProvider<GetTeachersBloc>(
        create: (context) => di.sl<GetTeachersBloc>()),
    BlocProvider<GetTeacherBloc>(create: (context) => di.sl<GetTeacherBloc>()),
    BlocProvider<BookingAppointmentBloc>(
        create: (context) => di.sl<BookingAppointmentBloc>()),
    BlocProvider<UpdateBookingAppointmentBloc>(
        create: (context) => di.sl<UpdateBookingAppointmentBloc>()),
    BlocProvider<DeleteAppointmentBloc>(
        create: (context) => di.sl<DeleteAppointmentBloc>()),
    BlocProvider<GetStudentAppointmentBloc>(
        create: (context) => di.sl<GetStudentAppointmentBloc>()),
    BlocProvider<GetStudentAppointmentsBloc>(
        create: (context) => di.sl<GetStudentAppointmentsBloc>()),
    BlocProvider<GetTeacherAppointmentBloc>(
        create: (context) => di.sl<GetTeacherAppointmentBloc>()),
    BlocProvider<GetTeacherAppointmentsBloc>(
        create: (context) => di.sl<GetTeacherAppointmentsBloc>()),
    BlocProvider<ContentBloc>(create: (context) => di.sl<ContentBloc>()),
    BlocProvider<ParagraphsBloc>(create: (context) => di.sl<ParagraphsBloc>()),
    BlocProvider<GetGoalsBloc>(create: (context) => di.sl<GetGoalsBloc>()),
    BlocProvider<PostsBloc>(create: (context) => di.sl<PostsBloc>()),

    BlocProvider<QuestionsBloc>(create: (context)=>di.sl<QuestionsBloc>()),
  ];
}
