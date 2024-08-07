import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField()
    static const String mongoDbUsername = _Env.mongoDbUsername;
    @EnviedField()
    static const String mongoDbPassword = _Env.mongoDbPassword;
    @EnviedField()
    static const String mongoDbHost = _Env.mongoDbHost;
    @EnviedField()
    static const String mongoDbName = _Env.mongoDbName;
    @EnviedField()
    static const String postgresDbUsername = _Env.postgresDbUsername;
    @EnviedField()
    static const String postgresDbPassword = _Env.postgresDbPassword;
    @EnviedField()
    static const String postgresDbHost = _Env.postgresDbHost;
    @EnviedField()
    static const String postgresDbName = _Env.postgresDbName;
    @EnviedField()
    static const String redisUsername = _Env.redisUsername;
    @EnviedField()
    static const String redisPassword = _Env.redisPassword;
    @EnviedField()
    static const String redisHost = _Env.redisHost;
    @EnviedField()
    static const int redisPort = _Env.redisPort;
}
