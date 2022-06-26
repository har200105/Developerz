import 'package:developerz/providers/developers.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditProfile extends StatefulWidget {
  final String id;
  const EditProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextfieldTagsController _controller = TextfieldTagsController();
  // late double _distanceToField;

  TextEditingController _bioController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bioController.text =
        Provider.of<DevelopersProvider>(context, listen: false)
                .getDeveloper!
                .bio ??
            "";
    _githubController.text =
        Provider.of<DevelopersProvider>(context, listen: false)
                    .getDeveloper!
                    .github !=
                null
            ? Provider.of<DevelopersProvider>(context, listen: false)
                    .getDeveloper!
                    .github ??
                ""
            : "";
    _linkedinController.text =
        Provider.of<DevelopersProvider>(context, listen: false)
                .getDeveloper!
                .linkedin ??
            "";
    _twitterController.text =
        Provider.of<DevelopersProvider>(context, listen: false)
                .getDeveloper!
                .twitter ??
            "";
    _websiteController.text =
        Provider.of<DevelopersProvider>(context, listen: false)
                .getDeveloper!
                .website ??
            "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _distanceToField = MediaQuery.of(context).size.width;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _twitternode = FocusScopeNode();
  final FocusScopeNode _websitenode = FocusScopeNode();
  final FocusScopeNode _skillsnode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Provider.of<DevelopersProvider>(context).getDeveloper != null
              ? Form(
                  key: _formKey,
                  child: Column(
                    // shrinkWrap: true,
                    children: [
                      const Text("Edit Profile",
                          style: TextStyle(fontSize: 25)),
                      const Text("Include http/https in all urls",
                          style:
                              TextStyle(fontSize: 15, color: Colors.redAccent)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 80.0, right: 80.0),
                        child: TextFormField(
                          controller: _bioController,
                          // initialValue: Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .bio ??
                          //     "",
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Enter your Short Bio",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                          controller: _githubController,
                          // focusNode: _node,
                          // initialValue: Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks!
                          //         .isNotEmpty
                          //     ? Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks![0]
                          //         .github
                          //     : "",
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText:
                                "Enter your Github url (Please include https/http)",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                          controller: _linkedinController,
                          // focusNode: _node,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Enter your Linkedin Profile Url",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                          controller: _twitterController,
                          // initialValue: Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks!
                          //         .isNotEmpty
                          //     ? Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks![0]
                          //         .twitter
                          //     : "",
                          focusNode: _twitternode,
                          onEditingComplete: () {
                            _twitternode.unfocus();
                            FocusScope.of(context).requestFocus(_websitenode);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Enter your Twitter url",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                          // autofocus: true,
                          controller: _websiteController,
                          focusNode: _websitenode,
                          // initialValue: Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks!
                          //         .isNotEmpty
                          //     ? Provider.of<DevelopersProvider>(context)
                          //         .getDeveloper!
                          //         .socialMediaLinks![0]
                          //         .website
                          //     : "",
                          onEditingComplete: () {
                            _websitenode.unfocus();
                            FocusScope.of(context).requestFocus(_skillsnode);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Enter your Website Url",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            hintStyle: const TextStyle(
                                fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                      ),
                      TextFieldTags(
                        textfieldTagsController: _controller,
                        textSeparators: const [' ', ','],
                        initialTags: Provider.of<DevelopersProvider>(context)
                                .getDeveloper!
                                .skills ??
                            [],
                        letterCase: LetterCase.normal,
                        validator: (String tag) {
                          if (_controller.getTags!.contains(tag)) {
                            return 'You have already entered that';
                          } else if (_controller.getTags!.length >= 3) {
                            return 'You can enter only up to 3 Tags';
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
                                focusNode: _skillsnode,
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
                                  hintText: 'Enter Your Major Tech Stacks...',
                                  errorText: error,
                                  prefixIconConstraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.74),
                                  prefixIcon: tags.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: sc,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: tags.map((String tag) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    color: Color.fromRGBO(
                                                        6, 40, 61, 1),
                                                  ),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          tag,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        onTap: () {
                                                          print(
                                                              "$tag selected");
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          size: 14.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233),
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
                      MaterialButton(
                        onPressed: () {
                          print(_controller.getTags.runtimeType);
                          Provider.of<DevelopersProvider>(context,
                                  listen: false)
                              .updateProfile(context,
                                  bio: _bioController.text,
                                  github: _githubController.text,
                                  linkedurl: _linkedinController.text,
                                  website: _websiteController.text,
                                  twitter: _twitterController.text,
                                  skills: _controller.getTags);
                        },
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color.fromRGBO(6, 40, 61, 1),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
      ),
    );
  }
}
