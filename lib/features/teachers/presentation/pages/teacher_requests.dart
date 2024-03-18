import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/teachers/presentation/bloc/teachers_requests/teachers_requests_bloc.dart';
import '../../domain/entities/teachers_requests.dart';
import '../bloc/teacher_request_details/teacher_request_details_bloc.dart';
import 'request_details.dart';
import '../widgets/search_bar_widgets/search_bar_widget.dart';


class TeacherRequests extends StatefulWidget {
  TeacherRequests({Key? key}) : super(key: key);

  @override
  State<TeacherRequests> createState() => _TeacherRequestsState();
}

class _TeacherRequestsState extends State<TeacherRequests> {
  ScrollController scroll = ScrollController();
  List<TeachersRequestsEntity> list = [];

  @override
  void initState() {
    BlocProvider.of<TeachersRequestsBloc>(context)
        .add(GetAllTeachersRequestsEvent(statuses: const ['3']));
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
            controller: scroll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SearchBarWidget(),
                BlocConsumer<TeachersRequestsBloc, TeachersRequestsState>(
                  listener: (context,state){
                    if(state is GetAllTeachersRequestsSuccess) {
                      list.addAll(state.list);
                    }
                  },
                    builder: (context, state) {
                  if (state is GetAllTeachersRequestsSuccess) {
                    list = state.list;
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                margin: EdgeInsets.all(8.w),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    border: Border()),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        list[index].userInfo.personalImage == null
                                            ? CircleAvatar(
                                          radius: 40.w,
                                          backgroundImage: const NetworkImage(
                                              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIEAdQMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAABAUGAwECB//EADQQAAICAQEGAgcHBQAAAAAAAAABAgMEEQUhMUFRcRIiEzJhkbHB0SNCUmKC4fAUM3KBof/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/ZQAAAAAAAAAAAAAAAAAAAAAAAAAAB8X2woqdlj0ijP5ufblSa1ca+UVz7lF1btDFqekrot9I+b4HNbVxG/Xkv0MzwLErVU31Xr7GyM/Ynv9x0MlFuLTi2muDRcbO2m5yVOS9ZPdGfX2MkFqACKAAAAAAAAABvRa9AKHbGS7ch1Rfkr3d3z+hXnspOcnJ8ZPVnhpAABAABWi2VkvIxl43rOHlft6MmFJsKemTZDlKGvuf7l2ZUAAAAAAAADWqa6gAZJxcW4vitzPCftfGdOS7EvJZv8A98yAaQAAQAAVZbCi3lTnyjDT3v8AYvCFsnGdGN4pLSdm969ORNM6uAAAAAAAAAAbUU3J6JcWwOeRTDIqlXYtYv3p9TPZmFbiS861hymluZaZG16a5eGqMrerT0RNpthk0qyG+ElwfwZUZUGjt2ZiWPX0fhf5HoclsfGT3u1/qX0LSKHtxLbZuzJeJXZMdEt8YPn3LKjEox99Vai+vFnHO2hDElGHhc5ve0npoiCYCNiZ1GVuhJxn+CXEkkUAAAAAADyUlCLlJpRitW3yA+b7oUVuy16RX/exns3Osy5aPy1p7oJ/HqeZ+XLLub3qtboR+ZGLiBKwc2zEm9PNW/Wj8+5FBRpaM/GuW62MX+GW5naV1UVq7a0vbJGUBIVe5e1qq14cf7SfX7q+pSWTlZOU5ycpSerb5nyCwFuaa5Fxs7aerVOTLfwjN/MpwBrgVex812L+ntfmS8j6roWhlQAACp25ktKOPB8fNPtyRbNqMXJ8FvZlci133zsf3nr2LhrmACsgAAAAAAAAAA9hOVc4zg9JReqZqMW9ZFELVzW9dHzMsWuwrtJ2UPg/Mu/P+ewkVcgAiou1LPR4NunGS8PvM2Xu3npi1pc7PkyiNYgAAgAAAAAAAAAAB3wbPRZlMvzJPs9xwGum9cgrXng113gyqt27/Zp/zfwKpcEAaxAABAAAAAAAAAAAD5s9R9gBqtRH1V2ABlX/2Q=="),
                                        )
                                            : CircleAvatar(
                                                radius: 40.w,
                                                backgroundImage: NetworkImage(
                                                    "${list[index].userInfo.personalImage}"),
                                              ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Name: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp,
                                                      color: Colors.blue),
                                                ),
                                                Text(
                                                  "${list[index].userInfo.firstName} ${list[index].userInfo.lastName}",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 20.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Email: ",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                Text(list[index].userInfo.email,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 20.sp)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Nationality: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: Colors.blue),
                                        ),
                                        Text(list[index].userInfo.nationality!.name!,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20.sp)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: Colors.blue),
                                        ),
                                        Text(list[index].status,
                                            style: TextStyle(
                                                color:list[index].status=="Pending"?Colors.orange:list[index].status=="Accepted"?Colors.green: Colors.red,
                                                fontSize: 20.sp)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: Colors.blue),
                                        ),
                                        Text(list[index].userInfo.birthDate,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.black87)),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {

                                          BlocProvider.of<
                                                      TeacherRequestDetailsBloc>(
                                                  context)
                                              .add(RequestTeacherDetailsEvent(
                                                  teacherId:
                                                      list[index].teacherId));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return  TeacherRequestDetails(status: list[index].status,);
                                          }));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Show details",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20.sp),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            const Icon(
                                              Icons.arrow_circle_right_outlined,
                                              color: Colors.blue,
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (state is GetAllTeachersRequestsLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        const Center(
                          child: Text("There are not any request."),
                        ),
                      ],
                    );
                  }
                }),
              ],
            )));
  }
}

