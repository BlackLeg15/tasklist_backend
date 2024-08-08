import 'package:tasklist_backend/extensions/hash_extension.dart';
import 'package:tasklist_backend/model/session_model.dart';

/// in-memory database
final sessionsDb = <String, SessionModel>{};

/// Class that provides methods related to Session
class SessionRepository {
  /// Creates a new session for a [userId]
  Future<SessionModel> createSession({required String userId}) {
    final currentDate = DateTime.now();
    final token = _generateToken(userId);
    final session = SessionModel(
      token: token,
      userId: userId,
      expiryDate: currentDate.add(const Duration(days: 1)),
      createdAt: currentDate,
    );

    sessionsDb[token] = session;

    return Future.value(session);
  }

  String _generateToken(String userId) {
    return '${userId}_${DateTime.now().toIso8601String()}'.hashValue;
  }

  /// Returns a [SessionModel] object from a [token]
  SessionModel? sessionByToken(String token) {
    final session = sessionsDb[token];

    if (session == null || session.expiryDate.isBefore(DateTime.now())) {
      return null;
    }

    return session;
  }
}
