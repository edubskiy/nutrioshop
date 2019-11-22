import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDDRH9W5W96qD9oNlY4BH3zdO679ZYlkno';
    final response = await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
    print('response from signup');
    print(json.decode(response.body));
  }

  Future<void> signin(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDDRH9W5W96qD9oNlY4BH3zdO679ZYlkno';
    final response = await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
    print('response from signin');
    print(json.decode(response.body));
  }
}
