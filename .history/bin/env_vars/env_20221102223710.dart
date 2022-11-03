import 'package:envied/envied.dart';

part 'env.g.dart'

@Envied()
abstract class Env {
    @EnviedField(envName: 'KEY')
    static const key = _Env.key;
}