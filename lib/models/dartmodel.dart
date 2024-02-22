class userdata {
  String? sId;
  String? title;
  String? description;
  bool? isActive;
  int? iV;

  userdata({this.sId, this.title, this.description, this.isActive, this.iV});

  userdata.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    isActive = json['isActive'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
