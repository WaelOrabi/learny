import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/core/constants.dart';
import 'package:learny_project/features/teachers/presentation/pages/show_details_teacher.dart';
import 'package:learny_project/features/content/presentation/pages/content_page_home.dart';
import 'package:learny_project/features/home/presentation/bloc/services_bloc/services_bloc.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/widgets/toast_widget.dart';
import '../../../appointment/presentation/pages/teacher_appointments_page.dart';
import '../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../auth/data/models/user_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../auth/presentation/bloc/logout/logout_bloc.dart';
import '../../../auth/presentation/pages/signup/sign-up.dart';

import '../../../teachers/presentation/pages/become_a_teacher.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../../../auth/presentation/pages/login/login.dart';
import 'package:learny_project/injection_container.dart' as di;

import '../../../teachers/presentation/pages/show_teahcers.dart';
import '../../../appointment/presentation/pages/student_appointments_page.dart';
import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/divider.dart';
import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/footer.dart';
import '../../../working_times/presentation/pages/working_times.dart';
import '../../domain/entities/get_best_teachers_entity.dart';
import '../bloc/get_best_teachers_bloc/get_best_teachers_bloc.dart';
import '../bloc/info_home_bloc/info_home_bloc.dart';
import '../bloc/packages_hours_price_bloc/packages_hours_price_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home page";
  UserModel? userModel;

  HomePage({Key? key, this.userModel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _personalInfoKey = GlobalKey<FormState>();
  bool isVisible = true;
  UserModel? userInformation;
  bool isTeacher = false;


  @override
  void initState() {
    super.initState();
    _getUserInformation();
    BlocProvider.of<InfoHomeBloc>(context).add(InfoHome());
    BlocProvider.of<GetBestTeachersBloc>(context).add(GetBestTeacher());

    BlocProvider.of<ServicesBloc>(context).add(GetServices());
    BlocProvider.of<PackagesHoursPriceBloc>(context)
        .add(GetPackagesHoursPrice());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
          child:
          BlocConsumer<LogoutBloc, LogoutState>(listener: (context, state) {
            if (state is LogoutSuccess) {
              widget.userModel = null;
            }
          }, builder: (context, state) {
            if (userInformation != null) {
              userInformation!.roles!.map((e) {
                if (e.name == "teacher") {
                  isTeacher = true;
                }
              }).toList();
            }
            return Scaffold(
                appBar: _buildAppBar(context: context, isVisible: isVisible),
                body: TabBarView(
                  children: [
                    BlocBuilder<InfoHomeBloc, InfoHomeState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100.h,
                              ),
                              Stack(
                                children: [

                                  Center(
                                    child: SvgPicture.asset(
                                      'assets/images/undraw_learning.svg',
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                      MediaQuery.of(context).size.height * 0.6,
                                    ),
                                  ),
                                  state is InfoHomeLoaded
                                      ? Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.04,
                                    top: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Text(
                                      state.infoHomeEntity.aboutUs
                                          .substring(0, 54),
                                      style: const TextStyle(
                                          color: Constants.secondaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : Text(''),
                                ],
                              ),
                              SizedBox(
                                height: 400.h,
                              ),
                              divider(40.h),
                              SizedBox(
                                height: 100.h,
                              ),
                              const Text(
                                  ' interactive teachers ',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(height: 100.h),
                              BlocBuilder<GetBestTeachersBloc, GetBestTeachersState>(
                                  builder: (context, state) {
                                    if (state is GetBestTeachersLoadedState) {
                                      List<BestTeacherEntity> list =
                                          state.getBestTeachersEntity.data;
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.8),
                                        child: GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ShowDetailsTeacher(teacherId: list[index].teacherId)));
                                                },child:Container(
                                              padding: const EdgeInsets.all(8).w,
                                              color: Colors.blue.withOpacity(0.1),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "${list[index].userInfo.firstName} ${list[index].userInfo.lastName}",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 30.sp,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 100.w,
                                                    backgroundImage: list[index]
                                                        .userInfo
                                                        .personalImage ==
                                                        null
                                                        ? const NetworkImage(
                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg",
                                                    )
                                                        : NetworkImage(
                                                      list[index]
                                                          .userInfo
                                                          .personalImage!,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("languages: ",
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Colors.black54)),
                                                      Row(
                                                        children: list[index]
                                                            .languages
                                                            .map((language) => Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 10,
                                                              right: 10),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                language
                                                                    .language,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                    20.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              Text(
                                                                language.level,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                    20.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                            .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("nationality: ",
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Colors.black54)),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                            "${list[index].userInfo.nationality!.name}",
                                                            style: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("rating: ",
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Colors.black54)),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 10, right: 5),
                                                        child: Text(
                                                            list[index]
                                                                .rating
                                                                .toStringAsFixed(2),
                                                            style: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                      ),
                                                      for (int i = 1;
                                                      i <=
                                                          list[index]
                                                              .rating
                                                              .truncate();
                                                      i++)
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:5,right:5),
                                                          child: Icon(
                                                            Icons.star,
                                                            color: Colors.yellow.shade600,
                                                            size: 20.w,
                                                          ),
                                                        ),
                                                      int.parse(list[index]
                                                          .rating
                                                          .toString()
                                                          .split('.')[1]) >=
                                                          5
                                                          ? Padding(
                                                        padding: const EdgeInsets.only(left: 5),
                                                        child: Icon(
                                                          Icons.star_half_outlined,
                                                          color: Colors
                                                              .yellow.shade600,
                                                          size: 20.w,
                                                        ),
                                                      )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                          },
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 10 / 2,
                                            crossAxisCount: 3,
                                            mainAxisExtent: 430.w,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 10.h,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const CircularProgressIndicator(
                                        backgroundColor: Constants.secondaryColor,
                                      );
                                    }
                                  }),
                              SizedBox(
                                height: 100.h,
                              ),
                              const Text(
                                ' Services provided by the platform ',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              BlocBuilder<ServicesBloc, ServicesState>(
                                builder: (context, state) {
                                  if (state is ServicesLoadedState) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: state.services.data
                                                .map((e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Constants
                                                      .secondaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                ),
                                                height: 250,
                                                width: 250,
                                                child: Center(
                                                  child: Text(
                                                    e.service,
                                                    style: const TextStyle(
                                                        color: Constants
                                                            .primaryColor,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator(
                                      backgroundColor: Constants.secondaryColor,
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              const Text(
                                'Offers on packages',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              BlocBuilder<PackagesHoursPriceBloc,
                                  PackagesHoursPriceState>(
                                builder: (context, state) {
                                  if (state is PackagesHoursPriceLoadedState) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: state
                                                .packagesHoursPriceEntity.data
                                                .map((e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Constants
                                                      .secondaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                ),
                                                height: 250,
                                                width: 250,
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 10,
                                                          bottom: 10),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize
                                                              .min,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: [
                                                            const Text(
                                                              'Price after discount \n',
                                                              style:
                                                              TextStyle(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${e.priceAfterDiscount} \$',
                                                              style:
                                                              const TextStyle(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize: 10,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          right: 10,
                                                          bottom: 10),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize
                                                              .min,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: [
                                                            const Text(
                                                              'Price\n',
                                                              style:
                                                              TextStyle(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${e.price} \$',
                                                              style:
                                                              const TextStyle(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize: 10,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                        child: Text(
                                                            '${e.numberOfHours} hours',
                                                            style: const TextStyle(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize:
                                                                30))),
                                                  ],
                                                ),
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator(
                                      backgroundColor: Constants.secondaryColor,
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 200.h,
                              ),
                              footer(context),
                            ],
                          ),
                        );
                      },
                    ),
                    const ShowTeachers(),
                     ContentPageHome(userModel: widget.userModel,),
                    isTeacher == true
                        ? const TeacherAppointmentsPage()
                        : const StudentAppointmentsPage()
                  ],
                ));
          })),
    );
  }

  AppBar _buildAppBar(
      {required BuildContext context, required bool isVisible}) {
    return AppBar(
      leadingWidth: 150.w,
      leading: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 30.h,
                backgroundImage: const AssetImage(
                  'assets/images/logo_white.png',
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "Learny",
                style: TextStyle(color: Colors.blue, fontSize: 25.sp),
              ),
              // Add more widgets here
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      title: TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(
            child: Row(
              children: [
                const Text("Home"),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(
                  Icons.home,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Tab(
            child: Row(
              children: [
                const Text("Teachers"),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(
                  Icons.school,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Tab(
            child: Row(
              children: [
                const Text("Content"),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(
                  Icons.interests,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Tab(
            child: Row(
              children: [
                const Text("Appointments"),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(
                  Icons.more_horiz,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: (widget.userModel != null || userInformation != null)
          ? [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
          splashRadius: 1.w,
        ),

        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            Navigator.of(context).pop();
          },
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            child: Padding(
              padding: const EdgeInsets.all(8.0).w,
              child: (userInformation!.personalImage != null &&
                  userInformation != null)
                  ? CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20.w,
                backgroundImage: NetworkImage(
                  userInformation!.personalImage!,
                ),
              )
                  : CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20.w,
                backgroundImage: NetworkImage(
                  "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIEAdQMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAABAUGAwECB//EADQQAAICAQEGAgcHBQAAAAAAAAABAgMEEQUhMUFRcRIiEzJhkbHB0SNCUmKC4fAUM3KBof/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/ZQAAAAAAAAAAAAAAAAAAAAAAAAAAB8X2woqdlj0ijP5ufblSa1ca+UVz7lF1btDFqekrot9I+b4HNbVxG/Xkv0MzwLErVU31Xr7GyM/Ynv9x0MlFuLTi2muDRcbO2m5yVOS9ZPdGfX2MkFqACKAAAAAAAAABvRa9AKHbGS7ch1Rfkr3d3z+hXnspOcnJ8ZPVnhpAABAABWi2VkvIxl43rOHlft6MmFJsKemTZDlKGvuf7l2ZUAAAAAAAADWqa6gAZJxcW4vitzPCftfGdOS7EvJZv8A98yAaQAAQAAVZbCi3lTnyjDT3v8AYvCFsnGdGN4pLSdm969ORNM6uAAAAAAAAAAbUU3J6JcWwOeRTDIqlXYtYv3p9TPZmFbiS861hymluZaZG16a5eGqMrerT0RNpthk0qyG+ElwfwZUZUGjt2ZiWPX0fhf5HoclsfGT3u1/qX0LSKHtxLbZuzJeJXZMdEt8YPn3LKjEox99Vai+vFnHO2hDElGHhc5ve0npoiCYCNiZ1GVuhJxn+CXEkkUAAAAAADyUlCLlJpRitW3yA+b7oUVuy16RX/exns3Osy5aPy1p7oJ/HqeZ+XLLub3qtboR+ZGLiBKwc2zEm9PNW/Wj8+5FBRpaM/GuW62MX+GW5naV1UVq7a0vbJGUBIVe5e1qq14cf7SfX7q+pSWTlZOU5ycpSerb5nyCwFuaa5Fxs7aerVOTLfwjN/MpwBrgVex812L+ntfmS8j6roWhlQAACp25ktKOPB8fNPtyRbNqMXJ8FvZlci133zsf3nr2LhrmACsgAAAAAAAAAA9hOVc4zg9JReqZqMW9ZFELVzW9dHzMsWuwrtJ2UPg/Mu/P+ewkVcgAiou1LPR4NunGS8PvM2Xu3npi1pc7PkyiNYgAAgAAAAAAAAAAB3wbPRZlMvzJPs9xwGum9cgrXng113gyqt27/Zp/zfwKpcEAaxAABAAAAAAAAAAAD5s9R9gBqtRH1V2ABlX/2Q==",
                ),
              ),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Container(
                    margin: const EdgeInsets.all(5).w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).w,
                      color: Colors.grey.shade200,
                    ),
                    child: ListTile(
                        title: Text(
                            userInformation != null
                                ? '${userInformation!.firstName} ${userInformation!.lastName}'
                                : '',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        subtitle:
                        Text("", style: TextStyle(fontSize: 10.sp)),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit)),
                        leading: userInformation!.personalImage != null
                            ? CircleAvatar(
                          backgroundColor:
                          Theme.of(context).primaryColor,
                          radius: 20.w,
                          backgroundImage: NetworkImage(
                            userInformation!.personalImage!,
                          ),
                        )
                            : CircleAvatar(
                          backgroundColor:
                          Theme.of(context).primaryColor,
                          radius: 20.w,
                          backgroundImage: NetworkImage(
                            "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIEAdQMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAABAUGAwECB//EADQQAAICAQEGAgcHBQAAAAAAAAABAgMEEQUhMUFRcRIiEzJhkbHB0SNCUmKC4fAUM3KBof/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/ZQAAAAAAAAAAAAAAAAAAAAAAAAAAB8X2woqdlj0ijP5ufblSa1ca+UVz7lF1btDFqekrot9I+b4HNbVxG/Xkv0MzwLErVU31Xr7GyM/Ynv9x0MlFuLTi2muDRcbO2m5yVOS9ZPdGfX2MkFqACKAAAAAAAAABvRa9AKHbGS7ch1Rfkr3d3z+hXnspOcnJ8ZPVnhpAABAABWi2VkvIxl43rOHlft6MmFJsKemTZDlKGvuf7l2ZUAAAAAAAADWqa6gAZJxcW4vitzPCftfGdOS7EvJZv8A98yAaQAAQAAVZbCi3lTnyjDT3v8AYvCFsnGdGN4pLSdm969ORNM6uAAAAAAAAAAbUU3J6JcWwOeRTDIqlXYtYv3p9TPZmFbiS861hymluZaZG16a5eGqMrerT0RNpthk0qyG+ElwfwZUZUGjt2ZiWPX0fhf5HoclsfGT3u1/qX0LSKHtxLbZuzJeJXZMdEt8YPn3LKjEox99Vai+vFnHO2hDElGHhc5ve0npoiCYCNiZ1GVuhJxn+CXEkkUAAAAAADyUlCLlJpRitW3yA+b7oUVuy16RX/exns3Osy5aPy1p7oJ/HqeZ+XLLub3qtboR+ZGLiBKwc2zEm9PNW/Wj8+5FBRpaM/GuW62MX+GW5naV1UVq7a0vbJGUBIVe5e1qq14cf7SfX7q+pSWTlZOU5ycpSerb5nyCwFuaa5Fxs7aerVOTLfwjN/MpwBrgVex812L+ntfmS8j6roWhlQAACp25ktKOPB8fNPtyRbNqMXJ8FvZlci133zsf3nr2LhrmACsgAAAAAAAAAA9hOVc4zg9JReqZqMW9ZFELVzW9dHzMsWuwrtJ2UPg/Mu/P+ewkVcgAiou1LPR4NunGS8PvM2Xu3npi1pc7PkyiNYgAAgAAAAAAAAAAB3wbPRZlMvzJPs9xwGum9cgrXng113gyqt27/Zp/zfwKpcEAaxAABAAAAAAAAAAAD5s9R9gBqtRH1V2ABlX/2Q==",
                          ),
                        )),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text("Profile",
                        style: TextStyle(
                            fontSize: 12.w, fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      // Handle profile option tap
                    },
                  ),
                ),
                PopupMenuItem(
                  enabled: userInformation!.roles![0].name != "owner",
                  child: ListTile(
                    title: Text("Become a Teacher",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.school_outlined),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context);
if(isTeacher){
  showToastWidgetSuccess("You are already a teacher");
}else {

  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BecomeATeacher()));
}
                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  enabled: userInformation!.roles![0].name != "teacher",
                  child: ListTile(
                    title: Text("Assign working times",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.access_time_rounded),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WorkingTimes()));
                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text("Setting",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.settings),
                    onTap: () {},
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text("Logout",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.logout_rounded),
                    onTap: () {
                      BlocProvider.of<LogoutBloc>(context)
                          .add(LogoutAuthEvent());
                    },
                  ),
                ),
              ];
            },
          ),
        ),
        // Add more actions if needed
      ]
          : [
        TextButton(
          onPressed: () {
            showCenterDialog(context, 'Sign up');
          },
          child: Text(
            'Sign up',
            style: MyAppTheme.myTheme.textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () {
            showCenterDialog(context, 'Login');
          },
          child: Text(
            'Login',
            style: MyAppTheme.myTheme.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  Future<void> _getUserInformation() async {
    try {
      userInformation = await _authLocalDataSourcesImpl.getCachedUser();
      setState(() {});
    } catch (error) {
      if (error is EmptyCacheException) {
        userInformation = null;
        //  showToastWidget('EmptyCacheException');
      }
    }
  }

  void showCenterDialog(BuildContext context, String logInOrSingUp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child: logInOrSingUp == 'Sign up' ? const SignUp() : Login()),
        );
      },
    );
  }

  void scrollToPersonalInfo(
      {required GlobalKey personalInfoKey,
        required ScrollController scrollController}) {
    final RenderBox? renderBox =
    personalInfoKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final scrollOffset = offset.dy - 100.h;
      scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
