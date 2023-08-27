class ChildImage {
  String url;
  bool child;

  ChildImage({
    required this.url,
    required this.child,
  });

  factory ChildImage.fromJson(Map<String, dynamic> json) {
    return ChildImage(
      url: json['url'] as String,
      child: json['child'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'child': child,
    };
  }
}
