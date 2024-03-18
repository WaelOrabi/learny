import '../../domain/entities/services_entity.dart';

class ServicesModel extends ServicesEntity{
  ServicesModel({ required super.data});

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceModel> dataList = list.map((i) => ServiceModel.fromJson(i)).toList();

    return ServicesModel(
      data: dataList,
    );
  }
}

class ServiceModel extends ServiceEntity{

  ServiceModel({required super.id, required super.service});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      service: json['service'],
    );
  }
}
