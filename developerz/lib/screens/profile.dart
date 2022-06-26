import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/editProfile.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    print("-------" + widget.id);
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Consumer<DevelopersProvider>(builder: (context, data, child) {
              if (data.getLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.getDeveloper != null &&
                  data.getLoading == false) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data.getDeveloper!.image ??
                          "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg"),
                      radius: 50.0,
                    ),
                    Text(data.getDeveloper!.name ?? ""),
                    Text(data.getDeveloper!.bio ?? ""),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      id: widget.id,
                                    )));
                      },
                      child: const Text("Update Profile"),
                    ),
                    const Text(
                      "Skills ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (data.getDeveloper!.skills != null)
                          for (int i = 0;
                              i < data.getDeveloper!.skills!.length;
                              i++)
                            Chip(
                              elevation: 10,
                              padding: const EdgeInsets.all(10),
                              backgroundColor:
                                  const Color.fromRGBO(6, 40, 61, 1),
                              label: Text(
                                data.getDeveloper!.skills![i],
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                      ],
                    ),
                    // if (data.getDeveloper!.socialMediaLinks!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (data.getDeveloper!.github != null &&
                            (data.getDeveloper!.github != ""))
                          IconButton(
                              onPressed: () async {
                                await launch((data.getDeveloper!.github!));
                              },
                              icon: const Icon(EvaIcons.githubOutline)),
                        if (data.getDeveloper!.linkedin != null &&
                            (data.getDeveloper!.linkedin != ""))
                          IconButton(
                              onPressed: () async {
                                await launch((data.getDeveloper!.linkedin!));
                              },
                              icon: const Icon(EvaIcons.linkedinOutline)),
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
                              icon: const Icon(EvaIcons.twitterOutline)),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            if (Provider.of<DevelopersProvider>(context).getDeveloper != null)
              Text(
                "Projects Done By " +
                    Provider.of<DevelopersProvider>(context)
                        .getDeveloper!
                        .name!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            Consumer<ProjectProvider>(builder: (context, data, snapshot) {
              if (data.getLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
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
                        description: "asdsd",
                        techStacks:
                            data.projectsUser[index].techStacksUsed ?? [],
                        // return Container();
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
