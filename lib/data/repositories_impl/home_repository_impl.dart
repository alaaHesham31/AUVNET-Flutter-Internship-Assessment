import '../../../domain/entities/service.dart';
import '../../../domain/repositories/home_repository.dart';
import '../datasources/remote/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Service>> getServices() {
    return remoteDataSource.fetchServices();
  }
}
