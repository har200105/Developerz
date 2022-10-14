import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/screens/editProfile.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:developerz/widgets/colorLoader.dart';
import 'package:developerz/widgets/modelBottomSheet.dart';
import 'package:developerz/widgets/profileDetail.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String id;
  const Profile({Key? key, required this.id}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void call() async {
    await Provider.of<ProjectProvider>(context, listen: false)
        .getProjectsDoneByDevelopersById(context, widget.id);
    await Provider.of<DevelopersProvider>(context, listen: false)
        .fetchDeveloperById(context, widget.id);
  }

  @override
  void initState() {
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DevelopersProvider>(builder: (context, data, child) {
              if (data.getLoading) {
                return Center(
                  child: ColorLoader2(
                    color1: Colors.blue,
                    color2: Colors.tealAccent,
                    color3: Colors.deepOrangeAccent,
                  ),
                );
              } else if (data.getDeveloper != null &&
                  data.getLoading == false) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(data
                                .getDeveloper!.image ??
                            "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg"),
                        radius: 50.0,
                      ),
                    ),
                    Text(data.getDeveloper!.name ?? ""),
                    Center(
                      child: SizedBox(
                          child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              data.getDeveloper!.bio ?? "",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(200, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(123, 9, 232, 143)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          id: widget.id,
                                        )));
                          },
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: const Text(
                        "Skills 🚀",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Wrap(
                      spacing: 2.0,
                      children: [
                        if (data.getDeveloper!.skills != null)
                          for (int i = 0;
                              i < data.getDeveloper!.skills!.length;
                              i++)
                            Chip(
                              elevation: 10,
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.teal.shade400,
                              label: Text(
                                data.getDeveloper!.skills![i],
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (data.getDeveloper!.github != null &&
                              (data.getDeveloper!.github != ""))
                            IconButton(
                                onPressed: () async {
                                  await launch((data.getDeveloper!.github!));
                                },
                                icon: const Icon(EvaIcons.github)),
                          if (data.getDeveloper!.linkedin != null &&
                              (data.getDeveloper!.linkedin != ""))
                            IconButton(
                                onPressed: () async {
                                  await launch((data.getDeveloper!.linkedin!));
                                },
                                icon: const Icon(EvaIcons.linkedinOutline,
                                    color: Colors.blue)),
                          if (data.getDeveloper!.website != null &&
                              data.getDeveloper!.website != "")
                            IconButton(
                                onPressed: () async {
                                  await launch((data.getDeveloper!.website!));
                                },
                                icon: const Icon(EvaIcons.link)),
                          if (data.getDeveloper!.twitter != null &&
                              data.getDeveloper!.twitter != "")
                            IconButton(
                                onPressed: () async {
                                  await launch((data.getDeveloper!.twitter!));
                                },
                                icon: const Icon(
                                  EvaIcons.twitterOutline,
                                  color: Colors.lightBlue,
                                )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (data.getDeveloper!.followers!.length > 0) {
                                  showFollowingsSheet(context,
                                      data.getDeveloper!.followers!, widget.id);
                                }
                              },
                              child: profileDetailBox(
                                  "Followers",
                                  data.getDeveloper!.followers!.length
                                      .toString())),
                          profileDetailBox(
                              "Projects",
                              Provider.of<ProjectProvider>(context,
                                      listen: false)
                                  .projectsUser
                                  .length
                                  .toString()),
                          GestureDetector(
                              onTap: () {
                                if (data.getDeveloper!.followings!.length > 0) {
                                  showFollowingsSheet(
                                      context,
                                      data.getDeveloper!.followings!,
                                      widget.id);
                                }
                              },
                              child: profileDetailBox(
                                  "Followings",
                                  data.getDeveloper!.followings!.length
                                      .toString())),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ColorLoader2(
                    color1: Colors.blue,
                    color2: Colors.tealAccent,
                    color3: Colors.deepOrangeAccent,
                  ),
                );
              }
            }),
            if (Provider.of<DevelopersProvider>(context).getDeveloper != null)
              Text(
                "Projects",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            Consumer<ProjectProvider>(builder: (context, data, snapshot) {
              if (Provider.of<DevelopersProvider>(context).getLoading ==
                      false &&
                  data.getLoading) {
                return Center(
                  child: ColorLoader2(
                    color1: Colors.blue,
                    color2: Colors.tealAccent,
                    color3: Colors.deepOrangeAccent,
                  ),
                );
              } else if (data.projectsUser.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.projectsUser.length,
                    itemBuilder: ((context, index) {
                      return ProjectCard(
                        id: data.projectsUser[index].sId,
                        projectName: data.projectsUser[index].name ?? "",
                        image: data.projectsUser[index].image,
                        developer: data.projectsUser[index].developer!.name,
                        description: data.projectsUser[index].about,
                        techStacks:
                            data.projectsUser[index].techStacksUsed ?? [],
                        developerId: data.projectsUser[index].developer!.sId,
                      );
                    }));
              } else {
                return const Center(
                  child: Text("No Projects Available"),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
