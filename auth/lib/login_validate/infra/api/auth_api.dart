



import 'dart:convert';

import '../../domain/token.dart';
import 'package:http/http.dart';

import '../../domain/credential.dart';
import 'package:async/async.dart';
import './auth_api_contract.dart';
import 'mapper.dart';

class AuthApi implements IAuthApi {
  final Client _client;
  String baseUrl;

  AuthApi(this.baseUrl ,this._client);

  @override
  Future<Result<String>> signIn(Credential credential) async {
    var endPoint = baseUrl + '/auth/signin';
    return await _postCredential(endPoint, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async{
    var endPoint = baseUrl + '/auth/signup';
    return await _postCredential(endPoint, credential);
  }

  Future<Result<String>>_postCredential(endPoint, Credential credential) async {
    var header = {
      "Content-type" : "application/json",
    };
    var response = await _client.post(endPoint, body: jsonEncode(Mapper.toJson(credential)),headers: header);
    if(response.statusCode != 200) return Result.error("Server error");
    var json = jsonDecode(response.body);
    return json['auth_token'] != null ? Result.value(json["auth_token"]): Result.error(json["message"]);
  }

  @override
  Future<Result<bool>> signOut(Token token)async {
    var url = baseUrl + '/auth/signout';
    var header = {
      "Content-type" : "application/json",
      "Authorization" : token.value
    };
    var response = await  _client.post(url, headers: header);
    if(response.statusCode != 200) return Result.error(false);
    return Result.value(true);
  }
}