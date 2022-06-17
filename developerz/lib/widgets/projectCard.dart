import 'package:developerz/screens/projectDetailScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String? projectName;
  final String? description;
  final String? image;
  final String? sourceCode;
  final String? liveLink;
  final String id;
  final List<String>? techStacks;
  final String? github;
  final String? link;

  const ProjectCard(
      {Key? key,
      this.projectName,
      this.description,
      required this.image,
      this.sourceCode,
      this.liveLink,
      required this.id,
      this.techStacks,
      this.github,
      this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(techStacks);
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectDetailScreen(id: id)));
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(backgroundImage: NetworkImage(image)),
                    if (image != null)
                      SizedBox(
                        height: 80.0,
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Image(image: NetworkImage(image!)),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(projectName ?? ""),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                //   child: Text(description ?? ""),
                // ),
                if (techStacks != null && techStacks!.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (techStacks != null && techStacks!.isNotEmpty)
                        for (int i = 0; i < techStacks!.length; i++)
                          Chip(
                            elevation: 10,
                            padding: const EdgeInsets.all(10),
                            backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
                            label: Text(
                              techStacks![i],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (github != null)
                      IconButton(
                          onPressed: () async {
                            if (await canLaunch(github!)) {
                              await launch(github!);
                            } else {
                              throw 'Could not launch $github!';
                            }
                          },
                          icon: const Icon(EvaIcons.githubOutline)),
                    if (link != null)
                      IconButton(
                          onPressed: () async {
                            await launch(link!);
                          },
                          icon: const Icon(EvaIcons.link)),
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
