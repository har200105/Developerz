import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:developerz/widgets/modelBottomSheet.dart';
import 'package:developerz/widgets/profileDetail.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/user.dart';
import '../widgets/colorLoader.dart';

class DeveloperProfile extends StatefulWidget {
  final String id;
  const DeveloperProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<DeveloperProfile> createState() => _DeveloperProfileState();
}

class _DeveloperProfileState extends State<DeveloperProfile> {
  @override
  void initState() {
    Provider.of<DevelopersProvider>(context, listen: false)
        .fetchDeveloperById(context, widget.id);
    Provider.of<ProjectProvider>(context, listen: false)
        .getProjectsDoneByDevelopersById(context, widget.id);
    Provider.of<ProjectProvider>(context, listen: false).resetProjectDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarExample()));
        Provider.of<DevelopersProvider>(context, listen: false)
            .resetDeveloperProfile();
        Provider.of<ProjectProvider>(context, listen: false)
            .resetProjectDetail();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(() => BottomNavigationBarExample(),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1));
                Provider.of<DevelopersProvider>(context, listen: false)
                    .resetDeveloperProfile();
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
                if (data.getLoading || data.getDeveloper == null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: ColorLoader2(
                        color1: Colors.blue,
                        color2: Colors.tealAccent,
                        color3: Colors.deepOrangeAccent,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(data
                                    .getDeveloper!.image ??
                                "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg"),
                            radius: 50.0,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(data.getDeveloper!.name ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                            height: 50.0,
                            width: 200.0,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: const Text(
                              "Skills 🚀",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
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
                                      await launch(
                                          (data.getDeveloper!.github!));
                                    },
                                    icon: const Icon(EvaIcons.github)),
                              if (data.getDeveloper!.linkedin != null &&
                                  (data.getDeveloper!.linkedin != ""))
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.linkedin!));
                                    },
                                    icon: const Icon(
                                      EvaIcons.linkedinOutline,
                                      color: Colors.blueAccent,
                                    )),
                              if (data.getDeveloper!.website != null &&
                                  data.getDeveloper!.website != "")
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.website!));
                                    },
                                    icon: const Icon(EvaIcons.link)),
                              if (data.getDeveloper!.twitter != null &&
                                  data.getDeveloper!.twitter != "")
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.twitter!));
                                    },
                                    icon: const Icon(
                                      EvaIcons.twitterOutline,
                                      color: Colors.lightBlueAccent,
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
                                    if (data.getDeveloper!.followers!.length >
                                        0) {
                                      showFollowingsSheet(
                                          context,
                                          data.getDeveloper!.followers!,
                                          widget.id);
                                    } else {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .showSnackBar(context,
                                              "No Followers Currently");
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
                                    if (data.getDeveloper!.followings!.length >
                                        0) {
                                      showFollowingsSheet(
                                          context,
                                          data.getDeveloper!.followings!,
                                          widget.id);
                                    } else {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .showSnackBar(context,
                                              "No Followings Currently");
                                    }
                                  },
                                  child: profileDetailBox(
                                      "Followings",
                                      data.getDeveloper!.followings!.length
                                          .toString())),
                            ],
                          ),
                        ),
                        if (Provider.of<UserProvider>(context).getIsUser &&
                            Provider.of<UserProvider>(context).loading ==
                                false &&
                            Provider.of<UserProvider>(context, listen: false)
                                    .user!
                                    .sId !=
                                widget.id)
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                int check = await data.getDeveloper!.followers!
                                    .indexWhere((user) =>
                                        user.sId ==
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .user!
                                            .sId);
                                if (check != -1) {
                                  Provider.of<DevelopersProvider>(context,
                                          listen: false)
                                      .unfollowDeveloper(context, widget.id)
                                      .whenComplete(() => {
                                            Provider.of<DevelopersProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchDeveloperById(
                                                    context, widget.id)
                                          });
                                } else {
                                  Provider.of<DevelopersProvider>(context,
                                          listen: false)
                                      .followDeveloper(context, widget.id)
                                      .whenComplete(() => {
                                            Provider.of<DevelopersProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchDeveloperById(
                                                    context, widget.id)
                                          });
                                }
                              },
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 50)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.indigo.shade600),
                              ),
                              child: Text(
                                data.getDeveloper!.followers!.indexWhere(
                                            (user) =>
                                                user.sId ==
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .user!
                                                    .sId) ==
                                        -1
                                    ? "Follow"
                                    : "Following",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        const Divider(
                          color: Colors.blueGrey,
                          thickness: 2.0,
                        ),
                      ],
                    ),
                  );
                }
              }),
              if (Provider.of<ProjectProvider>(context)
                      .projectsUser
                      .isNotEmpty &&
                  Provider.of<ProjectProvider>(context).getLoading == false &&
                  Provider.of<DevelopersProvider>(context, listen: false)
                          .getDeveloper !=
                      null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Projects done by " +
                        Provider.of<DevelopersProvider>(context)
                            .getDeveloper!
                            .name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black),
                  ),
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
                } else if (data.getLoading == false &&
                    data.projectsUser.isEmpty) {
                  return const Center(
                    child: Text("No Projects Available Currently"),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: data.projectsUser.length,
                      itemBuilder: ((context, index) {
                        return ProjectCard(
                          id: data.projectsUser[index].sId,
                          projectName: data.projectsUser[index].name,
                          image: data.projectsUser[index].image,
                          description: data.projectsUser[index].about,
                          techStacks:
                              data.projectsUser[index].techStacksUsed ?? [],
                          github: data.projectsUser[index].codeUrl,
                          link: data.projectsUser[index].liveUrl,
                          developer: data.projectsUser[index].developer!.name,
                          developerId: data.projectsUser[index].developer!.sId,
                        );
                      }));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
