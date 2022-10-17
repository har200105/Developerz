import 'package:developerz/screens/projectDetailScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String? projectName;
  final String? description;
  final String? image;
  final String? sourceCode;
  final String? liveLink;
  final String id;
  final List<String> techStacks;
  final String? github;
  final String? link;
  final String? developer;
  final String? developerId;

  const ProjectCard(
      {Key? key,
      this.projectName,
      this.description,
      required this.image,
      this.sourceCode,
      this.liveLink,
      required this.id,
      required this.techStacks,
      required this.developer,
      required this.developerId,
      this.github,
      this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProjectDetailScreen(id: id),
            transition: Transition.fade, duration: Duration(seconds: 1));
      },
      child: Card(
        elevation: 20,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (image != null && image != "")
                      Center(
                        child: Image(
                          image: NetworkImage(image!),
                          height: 150.0,
                          width: MediaQuery.of(context).size.width * 0.70,
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(projectName ?? "")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Center(child: Text(description ?? "")),
                ),
                if (techStacks.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(spacing: 2.0, children: [
                      for (int i = 0; i < techStacks.length; i++)
                        if (techStacks.length > i)
                          Chip(
                            elevation: 10,
                            padding: const EdgeInsets.all(10.0),
                            backgroundColor: Colors.teal.shade400,
                            label: Text(
                              techStacks[i],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                    ]),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (github != null && github != "")
                      IconButton(
                        onPressed: () async {
                          if (await canLaunch(github!)) {
                            await launch(github!);
                          } else {
                            throw 'Could not launch!';
                          }
                        },
                        icon: const Icon(EvaIcons.github),
                        tooltip: "Visit Project's Github Repo",
                      ),
                    if (link != null && link != "")
                      IconButton(
                        onPressed: () async {
                          await launch(link!);
                        },
                        icon: const Icon(EvaIcons.link),
                        tooltip: "Visit Project's Live Link",
                      ),
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
