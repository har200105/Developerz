class Developer {
  List<Data>? data;

  Developer({this.data});

  Developer.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? image;
  List<String>? skills;
  List<SocialMediaLinks>? socialMediaLinks;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? bio;
  String? pic;

  Data(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.skills,
      this.image,
      this.socialMediaLinks,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.bio,
      this.pic});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    skills = json['skills'].cast<String>();
    if (json['socialMediaLinks'] != null) {
      socialMediaLinks = <SocialMediaLinks>[];
      json['socialMediaLinks'].forEach((v) {
        socialMediaLinks!.add(new SocialMediaLinks.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bio = json['bio'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['skills'] = skills;
    data['image'] = image;
    if (socialMediaLinks != null) {
      data['socialMediaLinks'] =
          socialMediaLinks!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['bio'] = bio;
    data['pic'] = pic;
    return data;
  }
}

class SocialMediaLinks {
  String? github;

  SocialMediaLinks({this.github});

  SocialMediaLinks.fromJson(Map<String, dynamic> json) {
    github = json['github'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['github'] = github;
    return data;
  }
}
