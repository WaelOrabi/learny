import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:learny_project/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:learny_project/features/appointment/domain/usecases/booking_appointment_usecase.dart';
import 'package:learny_project/features/appointment/domain/usecases/get_student_appointment_usecase.dart';
import 'package:learny_project/features/appointment/domain/usecases/get_student_appointments_usecase.dart';
import 'package:learny_project/features/appointment/domain/usecases/get_teacher_appointment_usecase.dart';
import 'package:learny_project/features/appointment/domain/usecases/get_teacher_appointments_usecase.dart';
import 'package:learny_project/features/appointment/domain/usecases/update_booking_appointment_usecase.dart';
import 'package:learny_project/features/appointment/presentation/bloc/booking_appointment_bloc/booking_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_student_appointment_bloc/get_student_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_teacher_appointment/get_teacher_appointment_bloc.dart';
import 'package:learny_project/features/appointment/presentation/bloc/update_booking_appointment_bloc/update_booking_appointment_bloc.dart';

import 'package:learny_project/features/content/data/datasources/remote_data_sources/content_remote_data_source.dart';
import 'package:learny_project/features/content/data/datasources/remote_data_sources/content_reomte_data_source_impl.dart';
import 'package:learny_project/features/content/data/repositories/content_repositories_impl.dart';
import 'package:learny_project/features/content/domain/repositories/content_repository.dart';
import 'package:learny_project/features/content/domain/usecases/follow_or_unfollow_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/get_all_followers_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/get_category_paragraph_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/get_category_question_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/get_level_content_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/get_my_languages_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/create_paragraph_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/delete_paragraph_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/get_all_paragraphs_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/get_my_paragraphs_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/get_paragraph_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/paragraphs/update_paragraph_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/create_post_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/get_type_posts_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/questions/solve_question_use_case.dart';
import 'package:learny_project/features/content/presentation/bloc/content/content_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/paragraphs/paragraphs_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/posts/posts_bloc.dart';
import 'features/admin/domain/repositories/level_repository.dart';
import 'features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'features/appointment/data/datasources/appointment_remote_data_source_impl.dart';
import 'features/appointment/domain/usecases/change_state_appointment_usecase.dart';
import 'features/appointment/domain/usecases/delete_booking_appointment_usecase.dart';
import 'features/appointment/domain/usecases/get_goals_usecase.dart';
import 'features/appointment/presentation/bloc/accept_or_reject_appointment/accept_or_reject_appointment_bloc.dart';
import 'features/appointment/presentation/bloc/delete_appointment_bloc/delete_appointment_bloc.dart';
import 'features/appointment/presentation/bloc/get_goals_bloc/get_goals_bloc.dart';
import 'features/appointment/presentation/bloc/get_student_appointments_bloc/get_student_appointments_bloc.dart';
import 'features/appointment/presentation/bloc/get_teacher_appointments_bloc/get_teacher_appointments_bloc.dart';
import 'features/home/data/datasources/remote_data_sources/home_data_source.dart';
import 'features/home/data/datasources/remote_data_sources/home_data_source_impl.dart';
import 'features/home/data/repositories/repository_home_impl.dart';
import 'features/home/domain/repositories/repository_home.dart';
import 'features/home/domain/usecases/get_best_teacher_usecase.dart';
import 'features/home/domain/usecases/info_usecase.dart';
import 'features/home/domain/usecases/services_usecase.dart';
import 'features/home/domain/usecases/packages_hours_price_usecase.dart';
import 'features/home/domain/usecases/statistics_usecase.dart';
import 'features/home/presentation/bloc/get_best_teachers_bloc/get_best_teachers_bloc.dart';
import 'features/home/presentation/bloc/info_home_bloc/info_home_bloc.dart';
import 'features/home/presentation/bloc/packages_hours_price_bloc/packages_hours_price_bloc.dart';
import 'features/home/presentation/bloc/services_bloc/services_bloc.dart';
import 'features/content/domain/usecases/posts/delete_post_use_case.dart';
import 'features/content/domain/usecases/posts/get_all_posts_use_case.dart';
import 'features/content/domain/usecases/posts/get_my_posts_use_case.dart';
import 'features/content/domain/usecases/posts/get_post_use_case.dart';
import 'features/content/domain/usecases/questions/create_question_use_case.dart';
import 'features/content/domain/usecases/questions/delete_question_use_case.dart';
import 'features/content/domain/usecases/questions/get_all_questions_use_case.dart';
import 'features/content/domain/usecases/questions/get_my_questions_use_case.dart';
import 'features/content/domain/usecases/questions/get_question_use_case.dart';
import 'features/content/domain/usecases/questions/update_question_use_case.dart';
import 'features/content/presentation/bloc/questions/questions_bloc.dart';
import 'features/teachers/domain/usecases/accept_or_reject_request_teacher.dart';
import 'features/teachers/domain/usecases/get_all_requests_teachers.dart';
import 'features/teachers/domain/usecases/get_teacher_usecase.dart';
import 'features/teachers/domain/usecases/get_teachers_usecase.dart';
import 'features/teachers/domain/usecases/teacher_request_details_usecase.dart';
import 'features/admin/data/datasources/remote_data_sources/certificate_type_remote_data_source/certificate_type_remote_data_source.dart';
import 'features/admin/data/datasources/remote_data_sources/certificate_type_remote_data_source/certificate_type_remote_data_source_impl.dart';
import 'features/admin/data/datasources/remote_data_sources/country_remote_data_source/country_remote_data_source.dart';
import 'features/admin/data/datasources/remote_data_sources/country_remote_data_source/country_remote_data_source_impl.dart';
import 'features/admin/data/datasources/remote_data_sources/donor_type_remote_data_source/donor_type_remote_data_source.dart';
import 'features/admin/data/datasources/remote_data_sources/donor_type_remote_data_source/donor_type_remote_data_source_impl.dart';
import 'features/admin/data/datasources/remote_data_sources/language_remote_data_source/language_remote_data_source.dart';
import 'features/admin/data/datasources/remote_data_sources/language_remote_data_source/language_remote_data_source_impl.dart';
import 'features/admin/data/datasources/remote_data_sources/level_remote_data_source/level_remote_data_source.dart';
import 'features/admin/data/datasources/remote_data_sources/level_remote_data_source/level_remote_data_source_impl.dart';
import 'features/admin/data/repositories/certificate_type_repositories_impl.dart';
import 'features/admin/data/repositories/country_repositories_impl.dart';
import 'features/admin/data/repositories/donor_type_repositories_impl.dart';
import 'features/admin/data/repositories/language_repositories_impl.dart';
import 'features/admin/data/repositories/level_repositories_impl.dart';
import 'features/admin/domain/repositories/certificate_type_repository.dart';
import 'features/admin/domain/repositories/country_repository.dart';
import 'features/admin/domain/repositories/donor_type_repository.dart';
import 'features/admin/domain/repositories/language_repository.dart';
import 'features/admin/domain/usecases/certificate_types_usecase/add_certificate_type_usecase.dart';
import 'features/admin/domain/usecases/certificate_types_usecase/delete_certificate_type_usecase.dart';
import 'features/admin/domain/usecases/certificate_types_usecase/get_all_certificate_types_usecase.dart';
import 'features/admin/domain/usecases/countries_usecase/add_country_usecase.dart';
import 'features/admin/domain/usecases/countries_usecase/delete_country_usecase.dart';
import 'features/admin/domain/usecases/countries_usecase/get_all_countries_usecase.dart';
import 'features/admin/domain/usecases/donor_types_usecase/add_donor_type_usecase.dart';
import 'features/admin/domain/usecases/donor_types_usecase/delete_donor_type_usecase.dart';
import 'features/admin/domain/usecases/donor_types_usecase/get_all_donor_types_usecase.dart';
import 'features/admin/domain/usecases/languages_usecae/add_language_usecase.dart';
import 'features/admin/domain/usecases/languages_usecae/delete_language_usecase.dart';
import 'features/admin/domain/usecases/languages_usecae/get_all_language_usecase.dart';
import 'features/admin/domain/usecases/levels_usecase/add_level_usecase.dart';
import 'features/admin/domain/usecases/levels_usecase/delete_level_usecase.dart';
import 'features/admin/domain/usecases/levels_usecase/get_all_levels_usecase.dart';
import 'features/admin/presentation/bloc/certificate_type_bloc/certificate_type_bloc.dart';
import 'features/admin/presentation/bloc/country_bloc/country_bloc.dart';
import 'features/admin/presentation/bloc/donor_type_bloc/donor_type_bloc.dart';
import 'features/admin/presentation/bloc/language_bloc/language_bloc.dart';
import 'features/admin/presentation/bloc/level_bloc/level_bloc.dart';
import 'features/teachers/data/datasources/remote_data_source/teacher_remote_data_source.dart';
import 'features/teachers/data/datasources/remote_data_source/teacher_reomte_data_source_impl.dart';
import 'features/teachers/data/repositories/teacher_repositories_impl.dart';
import 'features/teachers/domain/repositories/teacher_repository.dart';
import 'features/teachers/domain/usecases/order_become_a_teacher_usecase.dart';
import 'features/teachers/presentation/bloc/accept_or_reject_request/accept_or_reject_request_bloc.dart';
import 'features/teachers/presentation/bloc/become_a_teacher/become_a_teacher_bloc.dart';
import 'features/teachers/presentation/bloc/get_teacher/get_teacher_bloc.dart';
import 'features/teachers/presentation/bloc/get_teachers/get_teachers_bloc.dart';
import 'features/teachers/presentation/bloc/teachers_requests/teachers_requests_bloc.dart';
import 'features/working_times/data/datasources/assign_working_time_data_source.dart';
import 'features/working_times/data/repositories/assign_working_time_repository_impl.dart';
import 'features/working_times/domain/repositories/assign_working_time_repository.dart';
import 'features/working_times/domain/usecases/assgin_working_time_usecase.dart';
import 'features/working_times/presentation/bloc/working_times_bloc.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import 'features/auth/data/datasources/remote_data_sources/auth_remote_data_sources.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/change_password_usecase.dart';
import 'features/auth/domain/usecases/check_otp_usecase.dart';
import 'features/auth/domain/usecases/forget_password_usecase.dart';
import 'features/auth/domain/usecases/log_out_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/send_otp_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/domain/usecases/verify_account.dart';
import 'features/auth/presentation/bloc/change_password/change_password_bloc.dart';
import 'features/auth/presentation/bloc/check_otp/check_otp_bloc.dart';
import 'features/auth/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'features/auth/presentation/bloc/send_otp/send_otp_bloc.dart';
import 'features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/auth/presentation/bloc/verify_account/verify_account_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/connectivity_service.dart';
import 'features/auth/data/datasources/local_data_sources/auth_local_data_source_impl.dart';
import 'features/auth/data/datasources/remote_data_sources/auth_remote_data_sources_impl.dart';
import 'features/teachers/presentation/bloc/teacher_request_details/teacher_request_details_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features . Auth
//Bloc
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory(() => LogoutBloc(logOutUseCase: sl()));
  sl.registerFactory(() => ChangePasswordBloc(changePasswordUseCase: sl()));
  sl.registerFactory(() => ForgetPasswordBloc(forgetPasswordUseCase: sl()));
  sl.registerFactory(() => VerifyAccountBloc(verifyAccountUseCase: sl()));
  sl.registerFactory(() => SendOtpBloc(sendOtpUseCase: sl()));
  sl.registerFactory(() => CheckOtpBloc(checkOtpUseCase: sl()));
  sl.registerFactory(() => WorkingTimesBloc(assignWorkingTimeUseCase: sl()));
  sl.registerFactory(
      () => TeachersRequestsBloc(getAllRequestsTeachersUseCase: sl()));
  sl.registerFactory(() => GetTeacherBloc(getTeacherUseCase: sl()));
  sl.registerFactory(() => GetTeachersBloc(
        getTeachersUseCase: sl(),
      ));

  sl.registerFactory(
      () => TeacherRequestDetailsBloc(teacherRequestDetailsUseCase: sl()));
  sl.registerFactory(
      () => AcceptOrRejectRequestBloc(acceptOrRejectRequestTeacher: sl()));
  sl.registerFactory(
      () => BecomeATeacherBloc(orderBecomeATeacherUseCase: sl()));
  sl.registerFactory(() => LevelBloc(
      addLevelUseCase: sl(),
      getAllLevelsUseCase: sl(),
      deleteLevelUseCase: sl()));
  sl.registerFactory(() => LanguageBloc(
      addLanguageUseCase: sl(),
      getAllLanguagesUseCase: sl(),
      deleteLanguageUseCase: sl()));
  sl.registerFactory(() => DonorTypeBloc(
      addDonorTypeUseCase: sl(),
      getAllDonorTypesUseCase: sl(),
      deleteDonorTypeUseCase: sl()));
  sl.registerFactory(() => CountryBloc(
      addCountryUseCase: sl(),
      deleteCountryUseCase: sl(),
      getAllCountriesUseCase: sl()));
  sl.registerFactory(() => CertificateTypeBloc(
      addCertificateTypeUseCase: sl(),
      getAllCertificateTypesUseCase: sl(),
      deleteCertificateTypeUseCase: sl()));
  sl.registerFactory(
      () => BookingAppointmentBloc(bookingAppointmentUseCase: sl()));
  sl.registerFactory(() =>
      UpdateBookingAppointmentBloc(updateBookingAppointmentUseCase: sl()));

  sl.registerFactory(() => DeleteAppointmentBloc(deleteBookingAppointmentUseCase: sl()));
  sl.registerFactory(()=>GetTeacherAppointmentsBloc(getTeacherAppointmentsUseCase: sl()));
  sl.registerFactory(()=>GetTeacherAppointmentBloc(getTeacherAppointmentUseCase: sl()));
  sl.registerFactory(()=>AcceptOrRejectAppointmentBloc(changeStateAppointmentUseCase: sl()));
  sl.registerFactory(() => GetStudentAppointmentBloc(getStudentAppointmentUseCase: sl()));
  sl.registerFactory(()=>GetStudentAppointmentsBloc(getStudentAppointmentsUseCase: sl()));
  sl.registerFactory(()=>GetGoalsBloc(getGoalsUseCase: sl()));
  sl.registerLazySingleton(() => InfoHomeBloc( infoUseCase:sl()));
  sl.registerLazySingleton(() => ServicesBloc( servicesUseCase:sl()));
  sl.registerLazySingleton(() => PackagesHoursPriceBloc( packagesHoursPriceUseCase:sl()));
  sl.registerLazySingleton(() => GetBestTeachersBloc(getBestTeachersUseCase: sl()));

  sl.registerFactory(() => ContentBloc(
      getCategoriesQuestionUseCase: sl(),
      getCategoryParagraphUseCase: sl(),
      getLevelContentUseCase: sl(),
      getMyLanguagesUseCase: sl(),
      followOrUnFollowUseCase: sl(),
      solveQuestionUseCase: sl(),
      getAllFollowersUseCase: sl()));
  sl.registerFactory(() => PostsBloc(
      getTypePostsUseCase: sl(),
      createPostUseCase: sl(),
      deletePostUseCase: sl(),
      getAllPostsUseCase: sl(),
      getMyPostsUseCase: sl(),
      getPostUseCase: sl()));
  sl.registerFactory(() => QuestionsBloc(
      getAllQuestionsUseCase: sl(),
      getMyQuestionsUseCase: sl(),
      getQuestionUseCase: sl(),
      createQuestionUseCase: sl(),
      deleteQuestionUseCase: sl(),
      updateQuestionUseCase: sl()));

  sl.registerFactory(() => ParagraphsBloc(
      createParagraphUseCase: sl(),
      deleteParagraphUseCase: sl(),
      getAllParagraphsUseCase: sl(),
      getMyParagraphsUseCase: sl(),
      getParagraphUseCase: sl(),
      updateParagraphUseCase: sl()));

//UseCase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => CheckOtpUseCase(sl()));
  sl.registerLazySingleton(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyAccountUseCase(sl()));
  sl.registerLazySingleton(() => TeacherRequestDetailsUseCase(sl()));
  sl.registerLazySingleton(
      () => AssignWorkingTimeUseCase(assignWorkingTimeRepository: sl()));
  sl.registerLazySingleton(() => AddCertificateTypeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCertificateTypeUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCertificateTypesUseCase(sl()));
  sl.registerLazySingleton(() => AddCountryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCountryUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCountriesUseCase(sl()));
  sl.registerLazySingleton(() => AddDonorTypeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDonorTypeUseCase(sl()));
  sl.registerLazySingleton(() => GetAllDonorTypesUseCase(sl()));
  sl.registerLazySingleton(() => AddLanguageUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLanguageUseCase(sl()));
  sl.registerLazySingleton(() => GetAllLanguagesUseCase(sl()));
  sl.registerLazySingleton(() => AddLevelUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLevelUseCase(sl()));
  sl.registerLazySingleton(() => GetAllLevelsUseCase(sl()));
  sl.registerLazySingleton(() => OrderBecomeATeacherUseCase(sl()));
  sl.registerLazySingleton(() => GetAllRequestsTeachersUseCase(sl()));
  sl.registerLazySingleton(
      () => AcceptOrRejectRequestTeacher(teacherRepository: sl()));
  sl.registerLazySingleton(() => GetTeachersUseCase(teacherRepository: sl()));
  sl.registerLazySingleton(() => GetTeacherUseCase(teacherRepository: sl()));
  sl.registerLazySingleton(
      () => BookingAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateBookingAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteBookingAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => GetTeacherAppointmentsUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => GetTeacherAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => GetStudentAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => GetStudentAppointmentsUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(() => GetGoalsUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(
      () => ChangeStateAppointmentUseCase(appointmentRepository: sl()));
  sl.registerLazySingleton(() => InfoUseCase(repositoryHome: sl()));
  sl.registerLazySingleton(
      () => PackagesHoursPriceUseCase(repositoryHome: sl()));
  sl.registerLazySingleton(() => ServicesUseCase(repositoryHome: sl()));
  sl.registerLazySingleton(() => StatisticsUseCase(repositoryHome: sl()));
  sl.registerLazySingleton(
      () => CreateParagraphUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteParagraphUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllParagraphsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => GetMyParagraphsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetParagraphUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateParagraphUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => CreatePostUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetMyPostsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetPostUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetTypePostsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => CreateQuestionUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteQuestionUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllQuestionsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => GetMyQuestionsUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetQuestionUseCase(contentRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateQuestionUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => SolveQuestionUseCase(contentRepository: sl()));

  sl.registerLazySingleton(() => FollowOrUnFollowUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetAllFollowersUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryQuestionUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryParagraphUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetLevelContentUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetMyLanguagesUseCase(contentRepository: sl()));
  sl.registerLazySingleton(() => GetBestTeachersUseCase(repositoryHome: sl()));
//Repository
  sl.registerLazySingleton<CertificateTypeRepository>(() =>
      CertificateTypeRepositoriesImpl(
          certificateTypeRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CountryRepository>(() => CountryRepositoriesImpl(
      countryRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<DonorTypeRepository>(() => DonorTypeRepositoriesImpl(
      donorTypeRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LanguageRepository>(() => LanguageRepositoriesImpl(
      languageRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LevelRepository>(() => LevelRepositoriesImpl(
        levelRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<TeacherRepository>(() => TeacherRepositoryImpl(
        teacherRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoriesImpl(
      authRemoteDataSource: sl(), networkInfo: sl(), localDataSources: sl()));
  sl.registerLazySingleton<AssignWorkingTimeRepository>(() =>
      AssignWorkingTimeRepositoryImpl(
          assignWorkingTimeRemoteDataSource: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton<AppointmentRepository>(() =>
      AppointmentRepositoryImpl(
          networkInfo: sl(), appointmentRemoteDataSource: sl()));
  sl.registerLazySingleton<RepositoryHome>(
      () => RepositoryHomeImpl(networkInfo: sl(), homeDataSource: sl()));
  sl.registerLazySingleton<ContentRepository>(() => ContentRepositoryImpl(
        networkInfo: sl(),
        contentRemoteDataSource: sl(),
      ));

//DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourcesImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<AuthLocalDataSources>(
      () => AuthLocalDataSourcesImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CertificateTypeRemoteDataSource>(
      () => CertificateTypeRemoteDataSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<CountryRemoteDataSource>(
      () => CountryRemoteDataSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<DonorTypeRemoteDataSource>(
      () => DonorTypeRemoteDataSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<LanguageRemoteDataSource>(
      () => LanguageRemoteDateSourceImpl());
  sl.registerLazySingleton<LevelRemoteDataSource>(
      () => LevelRemoteDateSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<TeacherRemoteDataSource>(
      () => TeacherRemoteDateSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<AssignWorkingTimeRemoteDataSource>(
      () => AssignWorkingTimeRemoteDataSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(authLocalDataSources: sl()));
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  sl.registerLazySingleton<ContentRemoteDataSource>(
      () => ContentRemoteDateSourceImpl(authLocalDataSources: sl()));

  ///Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivityService: sl()));

  ///External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => ConnectivityService());
  sl.registerLazySingleton(() => http.Client());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
