import 'package:developerz/providers/imageUtility.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/login.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                const Text("Signup", style: TextStyle(fontSize: 25)),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
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
                      hintStyle:
                          const TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                  child: TextFormField(
                    controller: _emailController,
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
                    utils.uploadImage();
                  },
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: const Text(
                    "Upload Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color.fromRGBO(6, 40, 61, 1),
                ),
                MaterialButton(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false).Signup(
                        context,
                        _nameController.text,
                        _emailController.text.trim().toLowerCase(),
                        _passwordController.text.trim(),
                        utils.userimage);
                  },
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color.fromRGBO(6, 40, 61, 1),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text("Already a user ?"))
              ],
            ),
          ),
        ]));
  }
}
