import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Consumer<ProjectProvider>(builder: (context, data, child) {
          if (data.getLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (data.getProject.image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Image(image: NetworkImage(data.getProject.image!)),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  data.getProject.name ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  data.getProject.about ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Developer: ${data.getProject.developer!.name}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(data.getProject.about ?? ""),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: const [
              //     Padding(
              //       padding: EdgeInsets.only(top: 10.0),
              //       child: Text(
              //         "22 Upvotes",
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(top: 10.0),
              //       child: Text(
              //         "10 Downvotes",
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data.getProject.techStacksUsed != null)
                    for (int i = 0;
                        i < data.getProject.techStacksUsed!.length;
                        i++)
                      Chip(
                        elevation: 10,
                        padding: const EdgeInsets.all(10),
                        backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
                        label: Text(
                          data.getProject.techStacksUsed![i],
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data.getProject.codeUrl != null)
                    IconButton(
                        onPressed: () async {
                          await launch((data.getProject.codeUrl!));
                        },
                        icon: const Icon(EvaIcons.githubOutline)),
                  if (data.getProject.liveUrl != null)
                    IconButton(
                        onPressed: () async {
                          await launch((data.getProject.liveUrl!));
                        },
                        icon: const Icon(EvaIcons.link)),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              // const Text("Upvote | Downvote"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //         onPressed: () {}, icon: const Icon(EvaIcons.arrowUp)),
              //     IconButton(
              //         onPressed: () {}, icon: const Icon(EvaIcons.arrowDown)),
              //   ],
              // )
            ],
          );
        }),
      ),
    );
  }
}
