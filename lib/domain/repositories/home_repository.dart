import '../entities/service.dart';

abstract class HomeRepository {
  Future<List<Service>> getServices();
}
