

import '../domain/auth_service_contract.dart';
import '../domain/token.dart';

class SignOutUsecase {
  final IAuthService _iAuthService;

  SignOutUsecase(this._iAuthService);

  Future<void> execute(Token token)async{
    return await _iAuthService.sigOut(token);
  }
}