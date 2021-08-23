

import 'package:flutter/material.dart';

class Credential {
  final AuthType authType;
  final String name;
  final String email;
  final String password;

  Credential({this.name,@required this.authType, @required this.email, this.password});
}

enum AuthType {email, google}