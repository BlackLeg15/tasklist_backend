import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch (context.request.method) {
    HttpMethod.patch => _updateTaskList(context, id),
    HttpMethod.delete => _deleteTaskList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _deleteTaskList(RequestContext context, String id) async {
  try {
    return context.read<Db>().collection('lists').deleteOne({'id': id}).then(
      (_) => Response(statusCode: HttpStatus.noContent),
    );
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

Future<Response> _updateTaskList(RequestContext context, String id) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final name = body['name'] as String?;
    return context.read<Db>().collection('lists').update(
      {'id': id},
      modify.set('name', name),
    ).then(
      (_) => Response(statusCode: HttpStatus.noContent),
    );
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}
