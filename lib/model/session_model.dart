/// A session class
class SessionModel {
  /// Constructor
  const SessionModel({
    required this.token,
    required this.userId,
    required this.expiryDate,
    required this.createdAt,
  });

  /// Session token
  final String token;

  /// User's ID
  final String userId;

  /// When this sesion's going to finish
  final DateTime expiryDate;
  
  /// When this session was created
  final DateTime createdAt;
}
