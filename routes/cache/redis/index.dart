import 'dart:developer';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _getLoginStatus(context),
    HttpMethod.post => _setLoginStatus(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getLoginStatus(RequestContext context) async {
  final command = context.read<Command>();
  final value = await command.send_object(['GET', 'loggedin']).then(
    (value) => value,
  );

  if (value == null || value is String && value.isEmpty) {
    const status = 0;
    await command.send_object(['SET', 'loggedin', status]);
    return Response(statusCode: HttpStatus.noContent);
  } else {
    return Response.json(body: int.parse(value.toString()));
  }
}

Future<Response> _setLoginStatus(RequestContext context) async {
  final command = context.read<Command>();
  final body = await context.request.json() as Map<String, dynamic>;
  final status = body['loggedin'] as int?;
  late final bool success;

  try {
    await command.send_object([
      'SET',
      'loggedin',
      status,
    ]);
    success = true;
  } catch (e) {
    success = false;
  }

  return Response.json(body: {'success': success});
}
