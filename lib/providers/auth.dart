import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutrioshop/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _timer;

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

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_timer != null) {
      _timer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _timer = Timer(Duration(seconds: timeToExpiry), logout);
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
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token, 
        'userId': _userId, 
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);

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

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if ( ! prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryData = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryData.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryData;
    _autoLogout();
    notifyListeners();

    return true;
  }
}
