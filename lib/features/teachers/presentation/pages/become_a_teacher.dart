import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../admin/presentation/bloc/country_bloc/country_bloc.dart';
import '../../../admin/presentation/bloc/donor_type_bloc/donor_type_bloc.dart';
import '../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../bloc/become_a_teacher/become_a_teacher_bloc.dart';
import '../../../admin/presentation/bloc/certificate_type_bloc/certificate_type_bloc.dart';
import '../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../widgets/becom_a_teacher_widgets/add_video.dart';
import '../widgets/becom_a_teacher_widgets/agree_and_submit.dart';
import '../widgets/becom_a_teacher_widgets/appbar_of_become_a_teacher.dart';
import '../widgets/becom_a_teacher_widgets/divider.dart';
import '../widgets/becom_a_teacher_widgets/footer.dart';
import '../widgets/becom_a_teacher_widgets/get_start_of_become_a_teacher.dart';
import '../widgets/becom_a_teacher_widgets/personal_information.dart';
import '../widgets/becom_a_teacher_widgets/teaching_languages_screen.dart';

class BecomeATeacher extends StatefulWidget {
  static const String routeName = "/become a teacher";

  BecomeATeacher({Key? key}) : super(key: key);

  @override
  State<BecomeATeacher> createState() => _BecomeATeacherState();
}

class _BecomeATeacherState extends State<BecomeATeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _personalInfoKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<CertificateTypeBloc>(context)
        .add(GetAllCertificateTypesEvent());
    BlocProvider.of<CountryBloc>(context).add(GetAllCountriesEvent());
    BlocProvider.of<DonorTypeBloc>(context).add(GetAllDonorTypesEvent());
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<LevelBloc>(context).add(GetAllLevelsEvent());
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<LanguageBloc, LanguageState>(listener: (context, state) {
            if (state is GetAllLanguagesSuccessState) {
              BlocProvider.of<BecomeATeacherBloc>(context).add(
                  FillOfListLanguagesEvent(
                      listLanguages: state.listAllLanguages));
            }
          }),
          BlocListener<LevelBloc, LevelState>(listener: (context, state) {
            if (state is GetAllLevelsSuccessState) {
              BlocProvider.of<BecomeATeacherBloc>(context)
                  .add(FillOfListLevelsEvent(listLevels: state.listAllLevels));
            }
          }),
          BlocListener<CertificateTypeBloc, CertificateTypeState>(
              listener: (context, state) {
            if (state is GetAllCertificateTypesSuccessState) {
              BlocProvider.of<BecomeATeacherBloc>(context).add(
                  FillOfListCertificateTypeEvent(
                      listCertificateTypes: state.listAllCertificateTypes));
            }
          }),
          BlocListener<CountryBloc, CountryState>(listener: (context, state) {
            if (state is GetAllCountriesSuccessState) {
              BlocProvider.of<BecomeATeacherBloc>(context).add(
                  FillOfListCountriesEvent(
                      listCountries: state.listAllCountries));
            }
          }),
          BlocListener<DonorTypeBloc, DonorTypeState>(
              listener: (context, state) {
            if (state is GetAllDonorTypesSuccessState) {
              BlocProvider.of<BecomeATeacherBloc>(context).add(
                  FillOfListDonorTypesEvent(
                      listDonorTypes: state.listAllDonorTypes));
            }
          }),
        ],
        child: BlocConsumer<BecomeATeacherBloc, BecomeATeacherState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: Form(
                  key: _formKey,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appbarOfBecome(),
                          getStartOfBecome(
                            personalInfoKey: _personalInfoKey,
                            scrollController: _scrollController,
                          ),
                          divider(40.h),
                          PersonalInformation(
                            personalInfoKey: _personalInfoKey,
                          ),
                          divider(0.h),
                          BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
                            builder: (context, state) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      BlocProvider.of<BecomeATeacherBloc>(context)
                                          .listTeachingLanguagesScreens
                                          .length,
                                  itemBuilder: (context, index) {
                                    return BlocProvider.of<BecomeATeacherBloc>(
                                                    context)
                                                .listTeachingLanguagesScreens
                                                .length ==
                                            1
                                        ? Center(
                                            child: TeachingLanguagesScreen(
                                            teachingLanguages: BlocProvider.of<
                                                    BecomeATeacherBloc>(context)
                                                .listTeachingLanguagesScreens[
                                                    index]
                                                .teachingLanguages,
                                            indexTeachingLanguage: index,
                                            deleteVisibility: false,
                                            listLanguages:
                                                BlocProvider.of<LanguageBloc>(
                                                        context)
                                                    .listLanguages,
                                            listLevels:
                                                BlocProvider.of<LevelBloc>(
                                                        context)
                                                    .listLevels,
                                          ))
                                        : TeachingLanguagesScreen(
                                            teachingLanguages: BlocProvider.of<
                                                    BecomeATeacherBloc>(context)
                                                .listTeachingLanguagesScreens[
                                                    index]
                                                .teachingLanguages,
                                            indexTeachingLanguage: index,
                                            deleteVisibility: true,
                                            listLanguages:
                                                BlocProvider.of<LanguageBloc>(
                                                        context)
                                                    .listLanguages,
                                            listLevels:
                                                BlocProvider.of<LevelBloc>(
                                                        context)
                                                    .listLevels,
                                          );
                                  });
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          divider(0.h),
                          const AddVideoTeacher(),
                          divider(20.h),
                          AgreeAndSubmit(formKey:_formKey,personalKey:_personalInfoKey),
                          SizedBox(
                            height: 40.h,
                          ),
                          footer(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
