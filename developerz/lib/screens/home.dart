import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/addProject.dart';
import 'package:developerz/screens/login.dart';
import 'package:developerz/screens/profile.dart';
import 'package:developerz/widgets/developerCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).setUser();
    Provider.of<DevelopersProvider>(context, listen: false)
        .fetchDevelopers(context);
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
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
          title: const Text(
            'Developerz',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(6, 40, 61, 1.0),
          child: Provider.of<UserProvider>(context).loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Provider.of<UserProvider>(context).getIsUser &&
                      Provider.of<UserProvider>(context).loading == false
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(Provider.of<
                                        UserProvider>(context, listen: false)
                                    .user!
                                    .image ??
                                "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg"),
                            radius: 50.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              Provider.of<UserProvider>(context, listen: false)
                                  .user!
                                  .name
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              Provider.of<UserProvider>(context, listen: false)
                                      .user!
                                      .bio ??
                                  "",
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile(
                                          id: Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .user!
                                              .sId!)));
                            },
                            child: const Text(
                              "Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddProject()));
                            },
                            child: const Text(
                              "Add Project",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<UserProvider>(context, listen: false)
                                  .logout();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          child: Center(
                              child: Text(
                            "Developerz",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
                    "Recently Joined Developers",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Consumer<DevelopersProvider>(builder: (context, data, snapshot) {
                if (data.getLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.getDevelopers.isEmpty) {
                  return const Center(
                    child: Text("No Developers Available Currently"),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: data.getDevelopers.length,
                      itemBuilder: ((context, index) {
                        return Developer(
                          id: data.getDevelopers[index].sId!,
                          name: data.getDevelopers[index].name,
                          image: data.getDevelopers[index].image ??
                              "https://thumbs.dreamstime.com/b/user-avatar-icon-button-profile-symbol-flat-person-icon-vector-user-avatar-icon-button-profile-symbol-flat-person-icon-%C3%A2%E2%82%AC-stock-131363829.jpg",
                          bio: data.getDevelopers[index].bio ?? "",
                          skills: data.getDevelopers[index].skills!,
                          github: data.getDevelopers[index].socialMediaLinks!
                                  .isNotEmpty
                              ? data.getDevelopers[index].socialMediaLinks![0]
                                  .github
                              : null,
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
