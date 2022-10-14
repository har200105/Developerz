import 'package:developerz/providers/imageUtility.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/login.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late AnimationController _controller1;
  late Animation<Offset> animation1;
  late AnimationController _controller2;
  late Animation<Offset> animation2;

  @override
  void initState() {
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
    );
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 4.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut),
    );

    _controller1.forward();
    _controller2.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var utils = Provider.of<UtilityNotifier>(context, listen: true);
    var userImage =
        Provider.of<UtilityNotifier>(context, listen: true).userimage;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(() => BottomNavigationBarExample(),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1));
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
        body: SlideTransition(
          position: animation2,
          child: Column(children: [
            userImage.isNotEmpty
                ? CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(utils.userimage),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      child: Image.asset(
                        "assets/developer.png",
                        width: 100.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: const Text("Signup At the Developerz",
                        style: TextStyle(fontSize: 25)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 80.0, right: 80.0),
                    child: TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Enter your Name",
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 80.0, right: 80.0),
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
                        hintStyle: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 80.0, right: 80.0),
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
                        hintStyle: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      utils.uploadImage();
                    },
                    icon: Icon(Icons.cloud_upload_outlined),
                    color: const Color.fromRGBO(6, 40, 61, 1),
                    tooltip: "Upload your pic",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(200, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(123, 9, 232, 143)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ))),
                        onPressed: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .Signup(
                                  context,
                                  _nameController.text,
                                  _emailController.text.trim().toLowerCase(),
                                  _passwordController.text.trim(),
                                  utils.userimage)
                              .whenComplete(() => {
                                    Provider.of<UtilityNotifier>(context,
                                            listen: false)
                                        .setUserImageVoid()
                                  });
                        },
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: const Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text("Already a user ?",
                            style: TextStyle(
                                color: Colors.indigo,
                                decoration: TextDecoration.underline))),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
