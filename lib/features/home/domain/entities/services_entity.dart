class ServicesEntity {
  final List<ServiceEntity> data;

  ServicesEntity({ required this.data});
}

class ServiceEntity {
  final int id;
  final String service;

  ServiceEntity({required this.id, required this.service});
}
