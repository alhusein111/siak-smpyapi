import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final String? token;
  final String? userName;
  final bool isLoading;

  AuthState({this.token, this.userName, this.isLoading = false});

  AuthState copyWith({String? token, String? userName, bool? isLoading}) {
    return AuthState(
      token: token ?? this.token,
      userName: userName ?? this.userName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(); 
  }

  Future<String?> login(String email, String password) async {
    state = state.copyWith(isLoading: true); 
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final userName = data['user']['name'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        await prefs.setString('user_name', userName);

        state = state.copyWith(token: token, userName: userName, isLoading: false);
        return null; 
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(isLoading: false);
        return errorData['message']; 
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Koneksi ke server gagal';
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_name');
    state = AuthState(); 
  }

  // FUNGSI INI DITAMBAHKAN DI SINI
  Future<bool> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final userName = prefs.getString('user_name');

    if (token != null && userName != null) {
      state = state.copyWith(token: token, userName: userName);
      return true; 
    }
    return false; 
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});