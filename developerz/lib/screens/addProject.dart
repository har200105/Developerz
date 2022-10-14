import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:developerz/providers/imageUtility.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _EditProfileState();
}

class _EditProfileState extends State<AddProject> {
  late TextfieldTagsController _controller;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _liveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                  transition: Transition.fade, duration: Duration(seconds: 1));
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: const Text("Share Your Projects 🚀",
                    style: TextStyle(fontSize: 25)),
              ),
              userImage.isNotEmpty && utils.userimage != ""
                  ? SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image(image: NetworkImage(utils.userimage)),
                    )
                  : SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0),
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter Project Name",
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
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter Project Description",
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
                  controller: _githubController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter Project Github Url",
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
                  controller: _liveController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter Project Live Url",
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
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFieldTags(
                  textfieldTagsController: _controller,
                  textSeparators: const [' ', ','],
                  initialTags: const [],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (_controller.getTags!.contains(tag)) {
                      return 'You have already entered that';
                    }
                    return null;
                  },
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, sc, tags, onTagDelete) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: tec,
                          focusNode: fn,
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(6, 40, 61, 1),
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(6, 40, 61, 1),
                                width: 3.0,
                              ),
                            ),
                            helperStyle: const TextStyle(
                              color: Color.fromRGBO(6, 40, 61, 1),
                            ),
                            hintText: 'Enter Project Tech Stacks....',
                            errorText: error,
                            prefixIconConstraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.74),
                            prefixIcon: tags.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: sc,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: tags.map((String tag) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                          color: Colors.teal,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                tag,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onTap: () {},
                                            ),
                                            const SizedBox(width: 4.0),
                                            InkWell(
                                              child: const Icon(
                                                Icons.cancel,
                                                size: 14.0,
                                                color: Color.fromARGB(
                                                    255, 233, 233, 233),
                                              ),
                                              onTap: () {
                                                onTagDelete(tag);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()),
                                  )
                                : null,
                          ),
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                        ),
                      );
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  utils.uploadImage();
                },
                icon: Icon(Icons.cloud_upload_outlined),
                color: const Color.fromRGBO(6, 40, 61, 1),
                tooltip: "Upload Project Pic",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(123, 9, 232, 143)),
                    ),
                    onPressed: () {
                      if (utils.userimage.isEmpty ||
                          utils.userimage == "" ||
                          utils.userimage.length == 0) {
                        AnimatedSnackBar.material(
                                "Please upload project picture",
                                type: AnimatedSnackBarType.error)
                            .show(context);
                        return;
                      }

                      if (_githubController.text.length != 0 &&
                          (!(_githubController.text.contains("https://") ||
                              _githubController.text.contains("http://")))) {
                        _githubController.text =
                            "https://" + _githubController.text;
                      }
                      if (_liveController.text.length != 0 &&
                          (!(_liveController.text.contains("https://") ||
                              _liveController.text.contains("http://")))) {
                        _liveController.text =
                            "https://" + _liveController.text;
                      }
                      Provider.of<ProjectProvider>(context, listen: false)
                          .addProject(
                              context,
                              _nameController.text,
                              _descriptionController.text,
                              _githubController.text,
                              _liveController.text,
                              utils.userimage,
                              _controller.getTags!)
                          .whenComplete(() => {
                                Provider.of<UtilityNotifier>(context,
                                        listen: false)
                                    .setUserImageVoid()
                              });
                    },
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: const Text(
                      "Add Project",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }
}
