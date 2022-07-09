import 'package:developerz/models/developer.dart';
import 'package:developerz/providers/developers.dart';
import 'package:developerz/screens/signup.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var auth = Provider.of<DevelopersProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarExample()));
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        title:
            const Text("Course River", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => const Signup())));
                    },
                  ),
                ],
              ),
            ),
            Form(
              key: formkey,
              child: Column(children: [
                const Text("Reset Password", style: TextStyle(fontSize: 25)),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                      controller: emailController,
                      // focusNode: FocusNode(),
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Email",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintStyle: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
                      // ignore:missing_return
                      validator: (a) {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color: Colors.white, width: 2.0)))),
                      onPressed: () async {
                        // await auth.sendForgotPasswordOTP(
                        //     context, emailController.text);
                        // FocusScope.of(context).unfocus();
                      },
                      child: const Text("Send OTP",
                          style: TextStyle(color: Colors.white))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: passwordController,
                    // focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      ),
                      labelText: "New password",
                      hintStyle: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Comic',
                          color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    // focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      ),
                      labelText: "Confirm password",
                      hintStyle: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Comic',
                          color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: otpController,
                    // focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "OTP",
                      hintStyle: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Comic',
                          color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color: Colors.white, width: 2.0)))),
                      onPressed: () async {
                        // await auth.resetPassword(
                        //     context,
                        //     emailController.text.trim().toLowerCase(),
                        //     passwordController.text.trim(),
                        //     otpController.text.trim());
                        // FocusScope.of(context).unfocus();
                      },
                      child: const Text("Confirm",
                          style: TextStyle(color: Colors.white))),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
