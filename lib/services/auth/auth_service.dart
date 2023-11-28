import 'package:vandad_course/services/auth/auth_providers.dart';
import 'package:vandad_course/services/auth/auth_user.dart';
import 'package:vandad_course/services/auth/firebase_auth_providers.dart';

class AuthService implements AuthProviders {
  final AuthProviders providers;

  AuthService(this.providers);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

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

  @override
  Future<void> initialize() => providers.initialize();
}
