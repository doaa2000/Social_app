class postModel {
  String? name;
  String? dateTime;
  String? uId;
  String? image;
  String? text;
  String? postImage;

  postModel({
    this.name,
    this.dateTime,
    this.uId,
    this.image,
    this.text,
    this.postImage,
  });

  postModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    postImage = json['postImage'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uId': uId,
      'image': image,
      'postImage': postImage,
    };
  }
}
