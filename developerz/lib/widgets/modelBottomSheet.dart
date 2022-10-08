import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showFollowingsSheet(BuildContext context) {
  ScrollController _controller1 = ScrollController();
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.white60,
            child: SingleChildScrollView(
              child: Scrollbar(
                controller: _controller1,
                thickness: 10,
                thumbVisibility: true,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: ((context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF100E20),
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=100"),
                          ),
                          title: Text(
                            "Harshit Rathi",
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            "Full Stack Developer",
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {},
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ));
                    })),
              ),
            ));
      });
}
