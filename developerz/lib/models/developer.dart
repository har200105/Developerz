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
  List<User>? followers;
  List<User>? followings;
  String? github;
  String? linkedin;
  String? website;
  String? twitter;
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
      this.github,
      this.linkedin,
      this.twitter,
      this.website,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.followers,
      this.followings,
      this.bio,
      this.pic});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    github = json['github'];
    if (json['followers'] != null) {
      followers = <User>[];
      json['followers'].forEach((v) {
        followers!.add(User.fromJson(v));
      });
    }
    if (json['followings'] != null) {
      followings = <User>[];
      json['followings'].forEach((v) {
        followings!.add(User.fromJson(v));
      });
    }

    linkedin = json['linkedin'];
    twitter = json['twitter'];
    website = json['website'];
    skills = json['skills'].cast<String>();
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
    data['github'] = github;
    data['linkedin'] = linkedin;
    data['twitter'] = twitter;
    data['followers'] = followers;
    data['followings'] = followings;
    data['website'] = website;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['bio'] = bio;
    data['pic'] = pic;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? image;
  String? bio;
  List<String>? followers;
  List<String>? followings;

  User({this.sId, this.name, this.bio, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    followers = json['followers'].cast<String>();
    followings = json['followings'].cast<String>();
    image = json['image'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['bio'] = bio;
    data['followers'] = followers;
    data['followings'] = followings;
    return data;
  }
}
