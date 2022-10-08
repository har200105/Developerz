import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/user.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String id;
  const ProjectDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false)
        .getProjectDetailsById(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<ProjectProvider>(context, listen: false)
            .resetProjectDetail();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarExample()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Provider.of<ProjectProvider>(context, listen: false)
                    .resetProjectDetail();
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
          child: Consumer<ProjectProvider>(builder: (context, data, child) {
            if (data.getLoading || data.getProject == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (data.getProject!.image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child:
                            Image(image: NetworkImage(data.getProject!.image!)),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    data.getProject!.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    data.getProject!.about ?? "",
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                          "Developer: ${data.getProject!.developer!.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(data.getProject!.about ?? ""),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Up votes :" +
                                data.getProject!.upvotes!.length.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Down votes :" +
                                data.getProject!.downvotes!.length.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Provider.of<UserProvider>(context).getIsUser &&
                        (data.getProject!.upvotes!
                                .map((element) => element.sId))
                            .contains(Provider.of<UserProvider>(context,
                                    listen: false)
                                .user!
                                .sId))
                      IconButton(
                          tooltip: "Downvote Project",
                          onPressed: () async {
                            await data.downVoteProject(context, widget.id);
                            await Provider.of<ProjectProvider>(context,
                                    listen: false)
                                .getProjectDetailsById(context, widget.id);
                          },
                          icon: const Icon(
                            EvaIcons.arrowCircleDown,
                            color: Colors.red,
                          )),
                    if (Provider.of<UserProvider>(context).getIsUser &&
                        (data.getProject!.downvotes!
                                .map((element) => element.sId))
                            .contains(Provider.of<UserProvider>(context,
                                    listen: false)
                                .user!
                                .sId))
                      IconButton(
                          tooltip: "Upvote Project",
                          onPressed: () async {
                            await data.upVoteProject(context, widget.id);
                            await Provider.of<ProjectProvider>(context,
                                    listen: false)
                                .getProjectDetailsById(context, widget.id);
                          },
                          icon: const Icon(
                            EvaIcons.arrowCircleUp,
                            color: Colors.green,
                          )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (data.getProject!.techStacksUsed != null)
                        for (int i = 0;
                            i < data.getProject!.techStacksUsed!.length;
                            i++)
                          Chip(
                            elevation: 10,
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.orangeAccent,
                            label: Text(
                              data.getProject!.techStacksUsed![i],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (data.getProject!.codeUrl != null)
                      IconButton(
                          onPressed: () async {
                            await launch((data.getProject!.codeUrl!));
                          },
                          icon: const Icon(EvaIcons.githubOutline)),
                    if (data.getProject!.liveUrl != null)
                      IconButton(
                          onPressed: () async {
                            await launch((data.getProject!.liveUrl!));
                          },
                          icon: const Icon(EvaIcons.link)),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
