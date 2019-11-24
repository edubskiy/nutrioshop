import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutrioshop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return _token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null && 
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null)  {
      return _token;
    }
    return null;
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;

    notifyListeners();
  }

  Future<void> _authentificate(String email, String password, String urlSegment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDDRH9W5W96qD9oNlY4BH3zdO679ZYlkno';

    try {
      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HTTPException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn'])
        )
      );
      notifyListeners();
    } catch (e) {
      throw(e);
    }

  }

  Future<void> signup(String email, String password) async {
    return _authentificate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authentificate(email, password, 'signInWithPassword');
  }
}
