
import '../../login_validate/domain/token.dart';
import 'package:async/async.dart';

abstract class IAuthService {
  Future<Result<Token>> sigIn();
  Future<Result<bool>> sigOut(Token token);
}