class ArticleModel {
  final int? id;
  final String? title;
  final String? description;
  final String? thumnail;
  final String? videoUrl;
  final String? sourceUrl;
  final bool? isVideo;
  final String? updateAt;
  final int? categoryId;
  final String? categoryName;

  ArticleModel({
    this.id,
    this.title,
    this.description,
    this.thumnail,
    this.videoUrl,
    this.sourceUrl,
    this.isVideo,
    this.updateAt,
    this.categoryId,
    this.categoryName,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumnail: json['thumnail'],
      videoUrl: json['video_url'],
      sourceUrl: json['source_url'],
      isVideo: json['is_video'],
      updateAt: json['updated_at'],
      categoryId: json['category_categorymodel']['id'],
      categoryName: json['category_categorymodel']['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumnail": thumnail,
        "videoUrl": videoUrl,
        "sourceUrl": sourceUrl,
        "isVideo": isVideo,
        "updated_at": updateAt,
      };
}