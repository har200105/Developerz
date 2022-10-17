import 'package:developerz/screens/developerProfileScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatelessWidget {
  final String? name;
  final String? bio;
  final String image;
  final String id;
  final List<String>? skills;
  final String? github;
  final String? linkedin;
  final String? twitter;
  final String? portfolio;

  const Developer(
      {Key? key,
      this.name,
      this.bio,
      required this.image,
      required this.id,
      this.skills,
      this.github,
      this.linkedin,
      this.twitter,
      this.portfolio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => DeveloperProfile(id: id),
              transition: Transition.zoom, duration: Duration(seconds: 1));
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white60,
              ),
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(image),
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          name!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Center(
                        child: Text(
                      bio!,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Wrap(
                    spacing: 2.0,
                    children: [
                      if (skills != null)
                        for (int i = 0; i < skills!.length; i++)
                          Chip(
                            elevation: 10,
                            padding: const EdgeInsets.all(3),
                            backgroundColor: Colors.teal.shade400,
                            label: Text(
                              skills![i],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (linkedin != null && linkedin != "")
                          IconButton(
                              onPressed: () async {
                                print(linkedin!);
                                await launchUrl(Uri.parse(linkedin!));
                              },
                              tooltip: "Visit $name's linkedin",
                              icon: const Icon(
                                EvaIcons.linkedinOutline,
                                color: Colors.blueAccent,
                              )),
                        if (github != null && github != "")
                          IconButton(
                              onPressed: () {
                                launch(github!);
                              },
                              tooltip: "Visit $name's github",
                              icon: const Icon(EvaIcons.github)),
                        if (portfolio != null && portfolio != "")
                          IconButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(portfolio!));
                              },
                              tooltip: "visit $name's Portfolio",
                              icon: const Icon(EvaIcons.link)),
                        if (twitter != null && twitter != "")
                          IconButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(twitter!));
                              },
                              tooltip: "Visit $name's Twitter",
                              icon: const Icon(
                                EvaIcons.twitter,
                                color: Colors.lightBlueAccent,
                              )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
