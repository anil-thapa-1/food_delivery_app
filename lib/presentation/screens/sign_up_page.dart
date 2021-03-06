import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/riverpod/notifier/signup_notifier.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final nameController = TextEditingController();

  void validate(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      try {
        ref.read(signUpNotifierProvider.notifier).signUp(
            nameController.text.trim(),
            emailController.text.trim(),
            passController.text.trim());
      } catch (e) {
        log(e.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Detail",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        ref.listen<SignupState>(signUpNotifierProvider, (previous, next) {
          if (next is SignupSuccess) {
            Fluttertoast.showToast(msg: "Signup Success");
            Navigator.pop(context);
          }
          if (next is SignupFailure) {
            Fluttertoast.showToast(msg: "Error: " + next.exception);
          }
        });

        final state = ref.watch(signUpNotifierProvider);
        if (state is SignupLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SignupFailure) {
          return _buildFailure(state, ref);
        } else if (state is SignupSuccess) {
          return _buildInitialData(context, ref);
        } else {
          return _buildInitialData(context, ref);
        }
      }),
    );
  }

  Padding _buildFailure(SignupFailure state, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Error: " + state.exception),
          ),
          IconButton(
              onPressed: () {
                ref.read(signUpNotifierProvider.notifier).reset();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }

  Widget _buildInitialData(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 250.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/signup.png"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Name Cannot be empty';
                      }
                      return null;
                    }),
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.r),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    }),
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password is too short!';
                      }
                      return null;
                    }),
                    obscureText: false,
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password is too short!';
                      } else if (value != passController.text) {
                        return 'Password Does Not Match';
                      }

                      return null;
                    }),
                    obscureText: false,
                    controller: confirmpassController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    height: 50.h,
                    width: 250.w,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        validate(ref);
                      },
                    )),
              ],
            )),
      ),
    );
  }
}
