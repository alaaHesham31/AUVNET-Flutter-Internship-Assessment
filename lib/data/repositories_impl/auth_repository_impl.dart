import '../../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<void> login(String email, String password) async {
    await remote.login(email, password);
  }

  @override
  Future<void> register(String email, String password) async {
    await remote.register(email, password);
  }
}
