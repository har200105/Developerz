import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/resetPassword.dart';
import 'package:developerz/screens/signup.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBarExample()));
              },
              icon: const Icon(Icons.arrow_back)),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
          title: const Text(
            'Developerz',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(children: [
          Form(
            key: formkey,
            child: Column(
              children: [
                const Text("Login", style: TextStyle(fontSize: 25)),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Enter your Username",
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
                      hintStyle:
                          const TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Enter your Password",
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
                      hintStyle:
                          const TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .LoginService(
                            context,
                            _emailController.text.trim().toLowerCase(),
                            _passwordController.text.trim());
                  },
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color.fromRGBO(6, 40, 61, 1),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    child: const Text("New To Developerz ?")),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: TextButton(
                //       onPressed: () async {
                //         Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => ResetPassword()));
                //       },
                //       child: const Text("Forget Password ?",
                //           style: TextStyle(color: Colors.black))),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: TextButton(
                //       onPressed: () async {
                //         Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const Signup()));
                //       },
                //       child: const Text("New User ?",
                //           style: TextStyle(color: Colors.black))),
                // ),
              ],
            ),
          ),
        ]));
  }
}
