import 'package:envied/envied.dart';
import 'string';

part 'env.g.dart'

@Envied()
abstract class Env {
    @EnviedField(varName: gnewsKey)
    static const key = _Env.key;
}