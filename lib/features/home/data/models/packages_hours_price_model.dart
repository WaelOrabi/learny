import 'package:learny_project/features/home/domain/entities/packages_hours_%20price_entity.dart';

class PackagesHoursPriceModel extends PackagesHoursPriceEntity{
  PackagesHoursPriceModel({ required super.data});

  factory PackagesHoursPriceModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PackageHoursPriceModel> dataList = list.map((i) => PackageHoursPriceModel.fromJson(i)).toList();

    return PackagesHoursPriceModel(
      data: dataList,
    );
  }
}

class PackageHoursPriceModel extends PackageHoursPriceEntity {


  PackageHoursPriceModel({required super.id, required super.numberOfHours, required super.discount, required super.price, required super.priceAfterDiscount});

  factory PackageHoursPriceModel.fromJson(Map<String, dynamic> json) {
    return PackageHoursPriceModel(
      id: json['id'],
      numberOfHours: json['number_of_hours'],
      discount: json['discount'].toDouble(),
      price: json['price'],
      priceAfterDiscount: json['price after discount'],
    );
  }
}
