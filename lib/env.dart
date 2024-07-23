import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField()
    static const String dbUsername = _Env.dbUsername;
    @EnviedField()
    static const String dbPassword = _Env.dbPassword;
    @EnviedField()
    static const String dbHost = _Env.dbHost;
    @EnviedField()
    static const String dbName = _Env.dbName;
}
