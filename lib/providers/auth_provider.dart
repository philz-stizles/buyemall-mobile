import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authExpiryTimer;

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  bool get isAuthenticated {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(Map<String, dynamic> credentials, endpoint) async {
    // Web API Key from Project's Console > Project Overview > Project settings
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$endpoint?key=AIzaSyB8H_J68N4F1zDfWXkW6qUmAbGmZU4yGQM');

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': credentials['email'],
            'password': credentials['password'],
            'returnSecureToken': true
          }));

      final responseBody = json.decode(response.body);
      // print(responseBody);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }

      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
      _setAutoLogoutTimer();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(Map<String, dynamic> credentials) async {
    return _authenticate(credentials, 'signUp'); // Return Future
  }

  Future<void> login(Map<String, dynamic> credentials) async {
    return _authenticate(credentials, 'signInWithPassword'); // Return Future
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    if (_authExpiryTimer != null) {
      _authExpiryTimer.cancel();
      _authExpiryTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _setAutoLogoutTimer() async {
    if (_authExpiryTimer != null) {
      _authExpiryTimer.cancel();
    }

    final secondsToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authExpiryTimer = Timer(Duration(seconds: secondsToExpiry), logout);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final decodedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(decodedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = decodedUserData['token'];
    _userId = decodedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _setAutoLogoutTimer();

    return true;
  }
}
