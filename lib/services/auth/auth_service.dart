import 'package:vandad_course/services/auth/auth_providers.dart';
import 'package:vandad_course/services/auth/auth_user.dart';

class AuthService implements AuthProviders {
  final AuthProviders providers;

  AuthService(this.providers);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      providers.createUser(
        email: email,
        password: password,
      );

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => providers.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      providers.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => providers.logOut();

  @override
  Future<void> sendEmailVerification() => providers.sendEmailVerification();
}
