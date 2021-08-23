

import '../../domain/credential.dart';

class Mapper {
  static Map<String, dynamic> toJson(Credential credential){
    return {
      "type": credential.authType,
      "name": credential.name,
      "email": credential.email,
      "password": credential.password
    };
  }
}