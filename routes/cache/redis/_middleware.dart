import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';

final conn = RedisConnection();

Handler middleware(Handler handler) {
  return (context) async {
    late final Response response;

    try {
      final command = await conn.connect('localhost', 6379);
      try {
        await command.send_object(['AUTH', 'default', 'test']);
        response = await handler
            .use(
              provider<Command>((_) => command),
            )
            .call(context);
      } catch (e) {
        response = Response.json(
          body: {'success': false, 'message': e.toString()},
        );
      }
    } catch (e) {
      response = Response.json(
        body: {'success': false, 'message': e.toString()},
      );
    }

    return response;
  };
}
