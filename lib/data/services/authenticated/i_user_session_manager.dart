import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';

abstract class IUserSessionManager {
  Future<void> addSession(String userId, UserSession session);
  Future<UserSession?> getSession(String userId);
  Future<void> removeSession(String userId);
  Future<Map<String, UserSession>> getSessions();
  Future<UserSession?> getAuthenticatedUser();
}
