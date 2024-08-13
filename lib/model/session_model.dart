import 'package:equatable/equatable.dart';

/// A session class
class SessionModel extends Equatable {
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
  
  @override
  List<Object?> get props => [token, userId, expiryDate, createdAt];
}
