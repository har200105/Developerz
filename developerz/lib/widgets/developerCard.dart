import 'package:developerz/screens/developerProfileScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DeveloperProfile(id: id)));
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(image)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(name!),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(bio!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (skills != null)
                      for (int i = 0; i < skills!.length; i++)
                        Chip(
                          elevation: 10,
                          padding: const EdgeInsets.all(3),
                          backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
                          label: Text(
                            skills![i],
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                    // Chip(
                    //   elevation: 10,
                    //   padding: EdgeInsets.all(10),
                    //   backgroundColor: Color.fromRGBO(6, 40, 61, 1),
                    //   label: Text(
                    //     'Django',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    // ),
                    // Chip(
                    //   elevation: 10,
                    //   padding: EdgeInsets.all(10),
                    //   backgroundColor: Color.fromRGBO(6, 40, 61, 1),
                    //   label: Text(
                    //     'Flutter',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (linkedin != null && linkedin != "")
                      IconButton(
                          onPressed: () async {
                            print(linkedin! + "sd");
                            await launchUrl(Uri.parse(linkedin!));
                          },
                          icon: const Icon(EvaIcons.linkedinOutline)),
                    if (github != null && github != "")
                      IconButton(
                          onPressed: () {
                            launch(github!);
                          },
                          icon: const Icon(EvaIcons.githubOutline)),
                    if (portfolio != null && portfolio != "")
                      IconButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(portfolio!));
                          },
                          icon: const Icon(EvaIcons.link)),
                    if (twitter != null && twitter != "")
                      IconButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(twitter!));
                          },
                          icon: const Icon(EvaIcons.twitter)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
