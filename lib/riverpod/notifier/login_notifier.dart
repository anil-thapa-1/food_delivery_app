import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
import 'package:food_delivery_app/data/network/auth_api.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthResponse authResponse;

  LoginSuccess(this.authResponse);
}

class LoginFailure extends LoginState {
  final String exception;

  LoginFailure(this.exception);
}

final loginStateNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(LoginInitial(),
      authenticationService: ref.watch(authServiceProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthService authenticationService;

  LoginNotifier(state, {required this.authenticationService})
      : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    try {
      state = LoginLoading();
      final response =
          await authenticationService.signIn(email: email, password: password);
      if (response != null) {
        state = LoginSuccess(response);
      } else {
        state = LoginFailure("Opps something went wrong.");
      }
    } catch (e) {
      state = LoginFailure(e.toString());
    }
  }

  Future<void> resetState() async {
    state = LoginInitial();
  }
}
