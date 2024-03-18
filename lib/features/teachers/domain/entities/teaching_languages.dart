import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../admin/domain/entities/language_entity.dart';
import '../../../admin/domain/entities/level_entity.dart';
import '../../presentation/widgets/becom_a_teacher_widgets/certificate.dart';

class TeachingLanguages extends Equatable{
  Language language;
  Level level;
   List<CertificateScreen> listCertificateScreen;

  TextEditingController yearOfExperience = TextEditingController();
  TeachingLanguages({required this.language,
     required this.level,
     required  this.yearOfExperience,
  required this.listCertificateScreen
  });

  @override
  List<Object?> get props => [language,level,yearOfExperience,listCertificateScreen];
}

