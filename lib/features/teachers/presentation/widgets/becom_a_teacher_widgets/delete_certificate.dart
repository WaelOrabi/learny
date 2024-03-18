import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';

Widget deleteCertificate(
    {required int indexTeachingLanguage, required int indexCertificate}) {
  return Tooltip(
    message: "delete",
    child: BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.black87,
          ),
          splashRadius: 2.w,
          onPressed: () {
            BlocProvider.of<BecomeATeacherBloc>(context).add(
                DeleteCertificateEvent(
                    indexTeachingLanguage: indexTeachingLanguage,
                    indexCertificate: indexCertificate));
          },
        );
      },
    ),
  );
}
