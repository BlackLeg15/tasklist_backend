import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:tasklist_backend/env.dart';

Handler middleware(Handler handler) {
  return (context) async {
    if (!Firestore.initialized) {
      Firestore.initialize(Env.firebaseProjectId);
    }

    final response = await handler(context);
    return response;
  };
}
