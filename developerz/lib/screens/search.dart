import 'package:developerz/providers/projects.dart';
import 'package:developerz/widgets/developerCard.dart';
import 'package:developerz/widgets/projectCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
              child: SizedBox(
                height: 54,
                width: double.infinity,
                child: TextField(
                  controller: controller,
                  onChanged: (text) {},
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Provider.of<ProjectProvider>(context, listen: false)
                            .getSearchedData(context, controller.text);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: 'Search For Developers or Projects',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (Provider.of<ProjectProvider>(context)
                .getSearchedProjects
                .isNotEmpty)
              const Text(
                "Projects",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            Consumer<ProjectProvider>(builder: ((context, value, child) {
              if (value.getLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: value.getSearchedProjects.length,
                    itemBuilder: ((context, index) {
                      return ProjectCard(
                          id: value.getSearchedProjects[index].sId,
                          projectName: value.getSearchedProjects[index].name,
                          image: value.getSearchedProjects[index].image,
                          description:
                              value.getSearchedProjects[index].about ?? "",
                          techStacks:
                              value.getSearchedProjects[index].techStacksUsed);
                    }));
              }
            })),
            if (Provider.of<ProjectProvider>(
              context,
            ).getSearchedDevelopers!.isNotEmpty)
              const Text(
                "Developers",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            Consumer<ProjectProvider>(builder: (context, data, snapshot) {
              if (data.getLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.getSearchedDevelopers!.length,
                    itemBuilder: ((context, index) {
                      return Developer(
                        id: data.getSearchedDevelopers![index].sId!,
                        name: data.getSearchedDevelopers![index].name,
                        image: data.getSearchedDevelopers![index].image ??
                            "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg",
                        bio: data.getSearchedDevelopers![index].bio ?? "",
                        skills: data.getSearchedDevelopers![index].skills,
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
