class PostModel{

  final String? postId;
  final String? registrationId;
  final String? imageUrl;
  final String? description;
  final String? location;

  PostModel({this.imageUrl, this.description, this.location, this.postId, this.registrationId});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      registrationId: json['registrationId'],
      postId: json['postId'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      location: json['location']
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'registrationId':registrationId,
    'postId' : postId,
    'imageUrl':imageUrl,
    'description':description,
    'location':location
  };

}