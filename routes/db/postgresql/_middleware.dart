import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:tasklist_backend/env.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final connection = await Connection.open(
      Endpoint(
        host: Env.postgresDbHost,
        database: Env.postgresDbName,
        username: Env.postgresDbUsername,
        password: Env.postgresDbPassword,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    final response = await handler
        .use(provider<Connection>((_) => connection))
        .call(context);

    await connection.close();

    return response;
  };
}
