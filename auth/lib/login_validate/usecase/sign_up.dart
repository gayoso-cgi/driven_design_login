import '../domain/sign_up_service_contract.dart';
import '../domain/token.dart';
import 'package:async/async.dart';

class SignUpUsecase {
  final ISignUpService _signUpService;

  SignUpUsecase(this._signUpService);

  Future<Result<Token>> execute(String name, String email, String password) async {
    return await _signUpService.sigUp(name, email, password);
  }
}
