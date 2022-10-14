import 'package:developerz/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyEmail extends StatefulWidget {
  @override
  final String email;
  const VerifyEmail({Key? key, required this.email}) : super(key: key);
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
        title: const Text(
          'Developerz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 900.0,
        width: 900.0,
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
            child: Column(children: [
              const Text("Verify Your Account", style: TextStyle(fontSize: 25)),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                child: TextFormField(
                    initialValue: widget.email,
                    focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Enter your Email",
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
                    validator: (a) {}),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                child: TextFormField(
                    controller: otpController,
                    focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "OTP",
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
                    // ignore:missing_return
                    validator: (a) {}),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("Verify",
                        style: TextStyle(color: Colors.white))),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
