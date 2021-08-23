
import '../domain/auth_service_contract.dart';
import '../../login_validate/domain/token.dart';
import 'package:async/async.dart';
class SigInUsecase {
  final IAuthService _iAuthService;

  SigInUsecase(this._iAuthService);

  Future<Result<Token>> execute()async {
    return await _iAuthService.sigIn();
  }
}