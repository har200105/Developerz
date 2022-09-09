import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBarExample()));
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(data
                                  .getDeveloper!.image ??
                              "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg"),
                          radius: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(data.getDeveloper!.name ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(data.getDeveloper!.bio ?? ""),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Text(
                            "Skills 🚀",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
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
                                  backgroundColor: Colors.teal,
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
                              if (data.getDeveloper!.github != null ||
                                  (data.getDeveloper!.github != ""))
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.github!));
                                    },
                                    icon: const Icon(EvaIcons.githubOutline)),
                              if (data.getDeveloper!.linkedin != null ||
                                  (data.getDeveloper!.linkedin != ""))
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.linkedin!));
                                    },
                                    icon: const Icon(EvaIcons.linkedinOutline)),
                              if (data.getDeveloper!.website != null ||
                                  data.getDeveloper!.website != "")
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.website!));
                                    },
                                    icon: const Icon(EvaIcons.link)),
                              if (data.getDeveloper!.twitter != null ||
                                  data.getDeveloper!.twitter != "")
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          (data.getDeveloper!.twitter!));
                                    },
                                    icon: const Icon(EvaIcons.twitterOutline)),
                            ],
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
