abstract class Env {
  static const String localIp = String.fromEnvironment(
    'LOCAL_IP',
    defaultValue: 'localhost',
  );
}
