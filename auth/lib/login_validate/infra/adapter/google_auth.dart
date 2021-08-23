
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/credential.dart';

import '../api/auth_api_contract.dart';

import '../../domain/token.dart';

import '../../../login_validate/domain/auth_service_contract.dart';

import 'package:async/async.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _authApi;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn googleSignIn]):
        this._googleSignIn = googleSignIn?? GoogleSignIn(scopes: ["email", "profile"]);


  @override
  Future<Result<Token>> sigIn() async {
    await _handleGoogleSigIn();
    if(_currentUser == null) return Result.error("Failed to sigin with google");
    Credential credential = Credential(authType: AuthType.google, email: _currentUser.email, name: _currentUser.displayName);
    var result = await _authApi.signIn(credential);
    if(result.isError)return result.asError;
    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<Result<bool>> sigOut(Token token) async {
    var result = await _authApi.signOut(token);
    if(result.asValue.value){
      _googleSignIn.disconnect();
    }
    return result;
  }

  _handleGoogleSigIn() async {
    try{
      _currentUser = await _googleSignIn.signIn();
    } catch (e){

    }
  }

}