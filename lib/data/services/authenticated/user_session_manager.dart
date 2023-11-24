import 'dart:convert';

import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_user_session_manager.dart';

class UserSessionManager implements IUserSessionManager {
  static const String _sessionKey = 'user_sessions';
  // TODO Trocar por flutter_segure_storage
  final SharedPreferences sharedPreferences;

  UserSessionManager(this.sharedPreferences);

  @override
  Future<void> addSession(String userId, UserSession session) async {
    final sessions = await getSessions();
    sessions[userId] = session;
    await sharedPreferences.setString(_sessionKey, json.encode(sessions));
  }

  @override
  Future<UserSession?> getSession(String userId) async {
    final sessions = await getSessions();
    return sessions[userId];
  }

  @override
  Future<void> removeSession(String userId) async {
    final sessions = await getSessions();
    sessions.remove(userId);
    await sharedPreferences.setString(_sessionKey, json.encode(sessions));
  }

  @override
  Future<Map<String, UserSession>> getSessions() async {
    final sessionsJson = sharedPreferences.getString(_sessionKey);
    if (sessionsJson != null) {
      final sessionsMap = json.decode(sessionsJson);
      return Map<String, UserSession>.from(
        sessionsMap.map((key, value) => MapEntry(
              key,
              UserSession.fromJson(value),
            )),
      );
    }
    return {};
  }

  @override
  Future<UserSession> getAuthenticatedUser() async {
    final sessions = await getSessions();

    final authenticatedSession =
        sessions.values.firstWhere((userSession) => userSession.isAuthenticated == true);

    return authenticatedSession;
  }
}
