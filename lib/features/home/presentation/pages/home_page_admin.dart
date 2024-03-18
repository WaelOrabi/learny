import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/home/presentation/pages/home_page.dart';
import 'package:learny_project/features/teachers/presentation/pages/teacher_requests.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/widgets/toast_widget.dart';
import '../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/bloc/logout/logout_bloc.dart';
import '../../../teachers/presentation/pages/become_a_teacher.dart';
import 'package:learny_project/injection_container.dart' as di;

class HomePageAdmin extends StatefulWidget {
  static const String routeName = "/home page admin";
  String? token;

  HomePageAdmin({Key? key, this.token}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  bool isVisible = true;
  UserModel? userInformation;

  @override
  void initState() {
    super.initState();
    _getUserInformation();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: SafeArea(
          child: BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context,state){
                if (state is LogoutSuccess) {
                  widget.token = null;
                }
              },
              builder: (context, state) {

                return Scaffold(
                    appBar: _buildAppBar(context: context, isVisible: isVisible),
                    body: TabBarView(
                      children: [
                        const Center(child: Text("Dashboard"),),
                        const Center(child: Text("Admins"),),
                        TeacherRequests(),
                        const Center(child: Text("More"),),
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
                style: TextStyle(color: Colors.blue,fontSize: 25.sp),
              ),
              // Add more widgets here
            ],
          ),
        ),
      ) ,
      backgroundColor: Theme.of(context).primaryColor,
      title: TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(child: Row(
            children: [
              const Text("Dashboard"),
              SizedBox(width: 4.w,),
              const Icon(Icons.dashboard,color: Colors.blue,)
            ],
          ),),

          Tab(child: Row(
            children: [
              const Text("Admins"),
              SizedBox(width: 4.w,),
              const Icon(Icons.admin_panel_settings,color: Colors.blue,)
            ],
          ),),
          Tab(child: Row(
            children: [
              const Text("Teachers"),
              SizedBox(width: 4.w,),
              const Icon(Icons.school,color: Colors.blue,)
            ],
          ),),
          Tab(child: Row(
            children: [
              const Text("More"),
              SizedBox(width: 4.w,),
              const Icon(Icons.more_horiz,color: Colors.blue,)
            ],
          ),),
        ],
      ),
      centerTitle: true,
      actions: [
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
              child:(userInformation!=null &&userInformation!.personalImage!=null )? CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20.w,
                backgroundImage:  NetworkImage(
                  userInformation!.personalImage!,
                ),
              ): CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20.w,
                backgroundImage:  NetworkImage(
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
                      title:  Text(userInformation != null?'${userInformation!.firstName} ${userInformation!.lastName}':'',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      subtitle: Text("",
                          style: TextStyle(fontSize: 10.sp)),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      leading:userInformation!.personalImage!=null? CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 20.w,
                        backgroundImage:  NetworkImage(
                          userInformation!.personalImage!,
                        ),
                      ):CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 20.w,
                        backgroundImage:  NetworkImage(
                          "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIEAdQMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAABAUGAwECB//EADQQAAICAQEGAgcHBQAAAAAAAAABAgMEEQUhMUFRcRIiEzJhkbHB0SNCUmKC4fAUM3KBof/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/ZQAAAAAAAAAAAAAAAAAAAAAAAAAAB8X2woqdlj0ijP5ufblSa1ca+UVz7lF1btDFqekrot9I+b4HNbVxG/Xkv0MzwLErVU31Xr7GyM/Ynv9x0MlFuLTi2muDRcbO2m5yVOS9ZPdGfX2MkFqACKAAAAAAAAABvRa9AKHbGS7ch1Rfkr3d3z+hXnspOcnJ8ZPVnhpAABAABWi2VkvIxl43rOHlft6MmFJsKemTZDlKGvuf7l2ZUAAAAAAAADWqa6gAZJxcW4vitzPCftfGdOS7EvJZv8A98yAaQAAQAAVZbCi3lTnyjDT3v8AYvCFsnGdGN4pLSdm969ORNM6uAAAAAAAAAAbUU3J6JcWwOeRTDIqlXYtYv3p9TPZmFbiS861hymluZaZG16a5eGqMrerT0RNpthk0qyG+ElwfwZUZUGjt2ZiWPX0fhf5HoclsfGT3u1/qX0LSKHtxLbZuzJeJXZMdEt8YPn3LKjEox99Vai+vFnHO2hDElGHhc5ve0npoiCYCNiZ1GVuhJxn+CXEkkUAAAAAADyUlCLlJpRitW3yA+b7oUVuy16RX/exns3Osy5aPy1p7oJ/HqeZ+XLLub3qtboR+ZGLiBKwc2zEm9PNW/Wj8+5FBRpaM/GuW62MX+GW5naV1UVq7a0vbJGUBIVe5e1qq14cf7SfX7q+pSWTlZOU5ycpSerb5nyCwFuaa5Fxs7aerVOTLfwjN/MpwBrgVex812L+ntfmS8j6roWhlQAACp25ktKOPB8fNPtyRbNqMXJ8FvZlci133zsf3nr2LhrmACsgAAAAAAAAAA9hOVc4zg9JReqZqMW9ZFELVzW9dHzMsWuwrtJ2UPg/Mu/P+ewkVcgAiou1LPR4NunGS8PvM2Xu3npi1pc7PkyiNYgAAgAAAAAAAAAAB3wbPRZlMvzJPs9xwGum9cgrXng113gyqt27/Zp/zfwKpcEAaxAABAAAAAAAAAAAD5s9R9gBqtRH1V2ABlX/2Q==",
                        ),
                      ),
                    ),
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
                  child: ListTile(
                    title: Text("Become a Teacher",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.school_outlined),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context);
                        showToastWidgetError("You can not to be a teacher,you are owner");
                        //
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => BecomeATeacher()));

                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text("Setting",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TeacherRequests()));

                      });

                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text("Logout",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
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
    );
  }

  Future<void>  _getUserInformation() async {
    try {
      userInformation = await _authLocalDataSourcesImpl.getCachedUser();
      setState(() {

      });
    } catch (error) {
      if (error is EmptyCacheException) {
        userInformation=null;
        //  showToastWidget('EmptyCacheException');
      }
    }
  }

}