import 'package:developerz/providers/projects.dart';
import 'package:developerz/screens/developerProfileScreen.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:developerz/widgets/colorLoader.dart';
import 'package:developerz/widgets/projectVotesCount.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    print("ID");
    print(Provider.of<UserProvider>(context, listen: false)
        .user!
        .sId!
        .toString());
    Provider.of<ProjectProvider>(context, listen: false)
        .getProjectDetailsById(context, widget.id);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return WillPopScope(
      onWillPop: () {
        Provider.of<ProjectProvider>(context, listen: false)
            .resetProjectDetail();
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Provider.of<ProjectProvider>(context, listen: false)
                    .resetProjectDetail();
                Get.to(() => BottomNavigationBarExample(),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1));
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
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                    child: ColorLoader2(
                      color1: Colors.blue,
                      color2: Colors.tealAccent,
                      color3: Colors.deepOrangeAccent,
                    ),
                  ));
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
                if (data.getProject!.developer!.sId!.toString() ==
                    Provider.of<UserProvider>(context).user!.sId!.toString())
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<ProjectProvider>(context, listen: false)
                              .deleteProject(context, widget.id)
                              .whenComplete(() => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeveloperProfile(
                                                    id: data.getProject!
                                                        .developer!.sId!))),
                                  });
                        },
                        icon: Icon(Icons.delete, color: Colors.red)),
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
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    data.getProject!.about ?? "",
                  ),
                ),
                if (data.getProject!.techStacksUsed != null)
                  Wrap(
                    spacing: 2.0,
                    runSpacing: 2.0,
                    children: [
                      for (int i = 0;
                          i < data.getProject!.techStacksUsed!.length;
                          i++)
                        Chip(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.teal.shade400,
                          label: Text(
                            data.getProject!.techStacksUsed![i],
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (data.getProject!.codeUrl != null)
                      IconButton(
                        onPressed: () async {
                          await launch((data.getProject!.codeUrl!));
                        },
                        icon: const Icon(
                          EvaIcons.githubOutline,
                          color: Colors.black,
                        ),
                        tooltip: "Visit Project's Github Repo",
                      ),
                    if (data.getProject!.liveUrl != null)
                      IconButton(
                        onPressed: () async {
                          await launch((data.getProject!.liveUrl!));
                        },
                        icon: const Icon(
                          EvaIcons.link,
                          color: Colors.black,
                        ),
                        tooltip: "Visit Project's Live Link",
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(0.0, 3.0),
                            blurRadius: 25.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: GestureDetector(
                            onTapDown: _tapDown,
                            onTapUp: _tapUp,
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeveloperProfile(
                                          id: data
                                              .getProject!.developer!.sId!)));
                            },
                            child: Transform.scale(
                              scale: _scale,
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x80000000),
                                        blurRadius: 12.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff33ccff),
                                        Color.fromARGB(255, 255, 241, 153),
                                      ],
                                    )),
                                child: Center(
                                  child: Text(
                                    "Visit Developer's Profile",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              projectVotesCount('Upvotes',
                                  data.getProject!.upvotes!.length.toString()),
                              projectVotesCount(
                                  'Downvotes',
                                  data.getProject!.downvotes!.length
                                      .toString()),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (Provider.of<UserProvider>(context).getIsUser &&
                                (!(data.getProject!.upvotes!
                                        .map((element) => element.sId))
                                    .contains(Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user!
                                        .sId)) &&
                                (!(data.getProject!.downvotes!
                                        .map((element) => element.sId))
                                    .contains(
                                        Provider.of<UserProvider>(context, listen: false)
                                            .user!
                                            .sId)))
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, bottom: 15.0),
                                    child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(150, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ))),
                                        onPressed: () async {
                                          await data.downVoteProject(
                                              context, widget.id);
                                          await Provider.of<ProjectProvider>(
                                                  context,
                                                  listen: false)
                                              .getProjectDetailsById(
                                                  context, widget.id);
                                        },
                                        icon: const Icon(
                                          EvaIcons.arrowDownOutline,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                        label: Text("Downvote")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(150, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ))),
                                        onPressed: () async {
                                          await data.upVoteProject(
                                              context, widget.id);
                                          await Provider.of<ProjectProvider>(
                                                  context,
                                                  listen: false)
                                              .getProjectDetailsById(
                                                  context, widget.id);
                                        },
                                        icon: const Icon(
                                          EvaIcons.arrowUpOutline,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                        label: Text("Upvote")),
                                  ),
                                ],
                              ),
                            if (Provider.of<UserProvider>(context).getIsUser &&
                                (data.getProject!.upvotes!
                                        .map((element) => element.sId))
                                    .contains(Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user!
                                        .sId))
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, bottom: 15.0),
                                child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(150, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ))),
                                    onPressed: () async {
                                      await data.downVoteProject(
                                          context, widget.id);
                                      await Provider.of<ProjectProvider>(
                                              context,
                                              listen: false)
                                          .getProjectDetailsById(
                                              context, widget.id);
                                    },
                                    icon: const Icon(
                                      EvaIcons.arrowDownOutline,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    label: Text("Downvote")),
                              ),
                            if (Provider.of<UserProvider>(context).getIsUser &&
                                (data.getProject!.downvotes!
                                        .map((element) => element.sId))
                                    .contains(Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user!
                                        .sId))
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(150, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ))),
                                    onPressed: () async {
                                      await data.upVoteProject(
                                          context, widget.id);
                                      await Provider.of<ProjectProvider>(
                                              context,
                                              listen: false)
                                          .getProjectDetailsById(
                                              context, widget.id);
                                    },
                                    icon: const Icon(
                                      EvaIcons.arrowUpOutline,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    label: Text("Upvote")),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
