class PackagesHoursPriceEntity {
  final List<PackageHoursPriceEntity> data;

  PackagesHoursPriceEntity({ required this.data});
}

class PackageHoursPriceEntity {
  final int id;
  final int numberOfHours;
  final double discount;
  final int price;
  final int priceAfterDiscount;

  PackageHoursPriceEntity({required this.id, required this.numberOfHours, required this.discount, required this.price, required this.priceAfterDiscount});

}
