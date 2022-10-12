import 'package:developerz/models/developer.dart';
import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/developerProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future showFollowingsSheet(
    BuildContext context, List<User> data, String currentId) {
  ScrollController _controller1 = ScrollController();
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            color: Colors.white60,
            child: SingleChildScrollView(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blueGrey,
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                        onTap: () {
                          Provider.of<DevelopersProvider>(context,
                                  listen: false)
                              .resetDeveloperProfile();
                          Provider.of<ProjectProvider>(context, listen: false)
                              .resetProjectDetail();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DeveloperProfile(id: data[index].sId!)));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF100E20),
                          backgroundImage: NetworkImage(data[index].image!),
                        ),
                        title: Text(
                          data[index].name!,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          data[index].bio!,
                          style: TextStyle(color: Colors.black, fontSize: 10.0),
                        ),
                        trailing: (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getIsUser &&
                                data[index].sId !=
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user!
                                        .sId)
                            ? MaterialButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  bool check = data[index].followers!.contains(
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .user!
                                          .sId);
                                  print(check);
                                  if (check) {
                                    Provider.of<DevelopersProvider>(context,
                                            listen: false)
                                        .unfollowDeveloper(
                                            context, data[index].sId!)
                                        .whenComplete(() => {
                                              Provider.of<DevelopersProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchDeveloperById(
                                                      context, currentId),
                                              Navigator.of(context).pop()
                                            });
                                  } else {
                                    Provider.of<DevelopersProvider>(context,
                                            listen: false)
                                        .followDeveloper(
                                            context, data[index].sId!)
                                        .whenComplete(() => {
                                              Provider.of<DevelopersProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchDeveloperById(
                                                      context, currentId),
                                              Navigator.of(context).pop()
                                            });
                                  }
                                },
                                child: Text(
                                  (data[index].followings!.contains(
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .user!
                                              .sId))
                                      ? 'Follow'
                                      : 'Following',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                                width: 0,
                              ));
                  })),
            ));
      });
}
