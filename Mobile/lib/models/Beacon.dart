class Beacon {
  String content_type;
  String content;
  String content_description;
  String id;
  String content_name;

  Beacon.fromJson(Map<String, dynamic> json) {
    content_type = json['content_type'];

    content = json['content'];
    content_description = json['content_description'];
    content_name = json['content_name'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() => {
      'content_type': this.content_type,
      'content': this.content,
      'content_description': this.content_description,
      'id': this.id,
      'content_name': this.content_name
    };
}