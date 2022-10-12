import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/colorLoader.dart';
import 'package:developerz/widgets/developerCard.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false).fetchProjects(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Recently Added Projects 🚀",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Consumer<ProjectProvider>(builder: (context, data, snapshot) {
              if (data.getLoading) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: ColorLoader2(
                        color1: Colors.blue,
                        color2: Colors.tealAccent,
                        color3: Colors.deepOrangeAccent,
                      ),
                    ));
              } else if (data.getLoading == false && data.getProjects.isEmpty) {
                return const Center(
                  child: Text("No Projects Available Currently"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.getProjects.length,
                    itemBuilder: ((context, index) {
                      return ProjectCard(
                        id: data.getProjects[index].sId,
                        projectName: data.getProjects[index].name,
                        image: data.getProjects[index].image,
                        description: data.getProjects[index].about,
                        techStacks:
                            data.getProjects[index].techStacksUsed ?? [],
                        github: data.getProjects[index].codeUrl,
                        link: data.getProjects[index].liveUrl,
                        developer: data.getProjects[index].developer!.name,
                        developerId: data.getProjects[index].developer!.sId,
                      );
                    }));
              }
            })
          ],
        ),
      ),
    );
  }
}
