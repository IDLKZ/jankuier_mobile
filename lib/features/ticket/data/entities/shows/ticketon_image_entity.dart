import 'package:equatable/equatable.dart';

class TicketonImage extends Equatable {
  final String? url;
  final String? alt;
  final bool? isMain;
  final bool? isCover;

  const TicketonImage({
    this.url,
    this.alt,
    this.isMain,
    this.isCover,
  });

  factory TicketonImage.fromJson(Map<String, dynamic> json) {
    return TicketonImage(
      url: json['url'],
      alt: json['alt'],
      isMain: json['main'] == 1 || json['main'] == true,
      isCover: json['cover'] == 1 || json['cover'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (url != null) 'url': url,
      if (alt != null) 'alt': alt,
      if (isMain != null) 'main': isMain! ? 1 : 0,
      if (isCover != null) 'cover': isCover! ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [url, alt, isMain, isCover];
}
