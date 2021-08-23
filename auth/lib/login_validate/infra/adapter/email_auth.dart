
import 'dart:html';

import 'package:flutter/foundation.dart';

import '../../../login_validate/domain/credential.dart';

import '../../../login_validate/infra/api/auth_api_contract.dart';

import '../../../login_validate/domain/token.dart';

import '../../../login_validate/domain/sign_up_service_contract.dart';

import '../../domain/auth_service_contract.dart';

import 'package:async/async.dart';

class EmailAuth implements IAuthService, ISignUpService {
  final IAuthApi _api;
  Credential _credential;

  EmailAuth(this._api);

  void credential({@required String email, @required String password}){
    _credential = Credential(authType: AuthType.email, email: email, password: password);
  }

  @override
  Future<Result<Token>> sigIn()async {
    assert(_credential != null);
    var result = await _api.signUp(_credential);
    if(result.isError)return result.asError;
    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<Result<bool>> sigOut(Token token) async{
    return await _api.signOut(token);
  }

  @override
  Future<Result<Token>> sigUp(String name, String email, String password) async {
    Credential credential = Credential(authType: AuthType.email,email: email,name: name, password: password);
    var result = await _api.signUp(credential);
    if(result.isError)return result.asError;
    return Result.value(Token(result.asValue.value));
  }

}