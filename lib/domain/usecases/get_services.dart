import '../entities/service.dart';
import '../repositories/home_repository.dart';

class GetServices {
  final HomeRepository repository;

  GetServices(this.repository);

  Future<List<Service>> call() {
    return repository.getServices();
  }
}
