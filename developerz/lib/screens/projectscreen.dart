import 'package:developerz/providers/projects.dart';
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
    // return AnnotatedRegion<SystemUiOverlayStyle>(
    // value: const SystemUiOverlayStyle(
    // For Android.
    // Use [light] for white status bar and [dark] for black status bar.
    // statusBarIconBrightness: Brightness.light,
    // For iOS.
    // Use [dark] for white status bar and [light] for black status bar.
    // statusBarBrightness: Brightness.light,
    // ),
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 1.0,
          // leading: const Drawer(),
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
                    "Recently Added Projects",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              // const ProjectCard(
              //   projectName: 'College Dost',
              //   image: "assets/collegedost.png",
              //   // "https://avatars.githubusercontent.com/u/79622524?s=400&u=c2b1823e2b1ee561118a7dc14b6ecf74d8090a87&v=4",
              //   description: "A Full Stack Web App To Help College Students",
              // ),
              // const ProjectCard(
              //   projectName: 'Course River',
              //   image: "assets/collegedost.png",
              //   // image:
              //   // "https://avatars.githubusercontent.com/u/79622524?s=400&u=c2b1823e2b1ee561118a7dc14b6ecf74d8090a87&v=4",
              //   description: "A Full Stack Mobile App To Rate Youtube Courses",
              // ),
              // const ProjectCard(
              //   projectName: 'Course River',
              //   image: "assets/collegedost.png",
              //   // image:
              //   // "https://avatars.githubusercontent.com/u/79622524?s=400&u=c2b1823e2b1ee561118a7dc14b6ecf74d8090a87&v=4",
              //   description: "A Full Stack Mobile App To Rate Youtube Courses",
              // ),
              // Developer(
              //   name: 'Amisha Purswani',
              //   image: "https://avatars.githubusercontent.com/u/66164747?v=4",
              //   bio: "Full Stack Developer | Competitive Programmer",
              // ),
              // Developer(),
              // Developer(),
              // Developer(),
              Consumer<ProjectProvider>(builder: (context, data, snapshot) {
                if (data.getLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.getLoading == false &&
                    data.getProjects.isEmpty) {
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
                          techStacks: data.getProjects[index].techStacksUsed,
                          github: data.getProjects[index].codeUrl,
                          link: data.getProjects[index].liveUrl,
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
