import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects projects) => json.encode(projects.toJson());

class Projects {
  Projects({
    required this.projects,
  });

  List<Project> projects;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        projects: List<Project>.from(
            json["projects"].map((x) => Project.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
      };
}

class Project {
  late String sId;
  String? name;
  String? image;
  String? codeUrl;
  String? liveUrl;
  Developer? developer;
  List<String>? techStacksUsed;
  String? about;
  List<Developer>? upvotes;
  List<Developer>? downvotes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Project(
      {required this.sId,
      this.name,
      this.codeUrl,
      this.liveUrl,
      this.developer,
      this.techStacksUsed,
      this.about,
      this.image,
      this.upvotes,
      this.downvotes,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Project.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    codeUrl = json['codeUrl'];
    liveUrl = json['liveUrl'];
    image = json['image'];
    developer = json['developer'] != null
        ? Developer.fromJson(json['developer'])
        : null;
    techStacksUsed = json['techStacksUsed'].cast<String>();
    about = json['about'];
    if (json['upvotes'] != null) {
      upvotes = <Developer>[];
      json['upvotes'].forEach((v) {
        upvotes!.add(Developer.fromJson(v));
      });
    }
    if (json['downvotes'] != null) {
      downvotes = <Developer>[];
      json['downvotes'].forEach((v) {
        downvotes!.add(Developer.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['codeUrl'] = codeUrl;
    data['liveUrl'] = liveUrl;
    if (developer != null) {
      data['developer'] = developer!.toJson();
    }
    data['techStacksUsed'] = techStacksUsed;
    data['about'] = about;
    if (upvotes != null) {
      data['upvotes'] = upvotes!.map((v) => v.toJson()).toList();
    }
    if (downvotes != null) {
      data['downvotes'] = downvotes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Developer {
  String? sId;
  String? name;

  Developer({this.sId, this.name});

  Developer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
