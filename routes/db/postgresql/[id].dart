import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

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

Future<Response> _updateTaskList(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final result = await context.read<Connection>().execute(
        "UPDATE lists SET name = '$name' WHERE id = '$id'",
      );
  if (result.affectedRows == 1) {
    return Response.json(body: {'success': true});
  }
  return Response(statusCode: HttpStatus.badRequest);
}

Future<Response> _deleteTaskList(RequestContext context, String id) async {
  final result = await context.read<Connection>().execute(
        'DELETE FROM lists WHERE id = $id',
      );
  if (result.affectedRows == 1) {
    return Response.json(body: {'success': true});
  }
  return Response(statusCode: HttpStatus.badRequest);
}
