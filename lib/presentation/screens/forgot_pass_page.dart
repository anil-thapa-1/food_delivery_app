import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

class ForgotPassPage extends ConsumerWidget {
  ForgotPassPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: Image.asset("assets/images/forgot.png")),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Email.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Email"),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 55.h,
                width: MediaQuery.of(context).size.width.w * .8,
                child: ElevatedButton(
                  onPressed: () async {
                    final isValid = _globalKey.currentState!.validate();
                    if (isValid) {
                      final String status = await ref
                          .read(firebaseServiceProvider)
                          .resetPassword(emailController.text.trim());
                      if (status == "Reset Sent Success") {
                        Fluttertoast.showToast(msg: "Reset Sent");
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: status);
                      }
                    }
                  },
                  child: const Text("Send Email"),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
