import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_image_entity.dart';

class TicketonShowsEventEntity extends Equatable {
  final String? id;
  final String? name;
  final String? genre;
  final String? description;
  final String? information;
  final String? imageUrl;
  final int? duration;
  final String? type;
  final double? ratingKp;
  final double? ratingImdb;
  final String? director;
  final String? actors;
  final String? country;
  final String? year;
  final String? remark;
  final List<TicketonImage>? images;
  final List<dynamic>? video;
  final String? soldedCount;
  final int? recommended;
  final String? cover;
  final String? main;

  const TicketonShowsEventEntity({
    this.id,
    this.name,
    this.genre,
    this.description,
    this.information,
    this.imageUrl,
    this.duration,
    this.type,
    this.ratingKp,
    this.ratingImdb,
    this.director,
    this.actors,
    this.country,
    this.year,
    this.remark,
    this.images,
    this.video,
    this.soldedCount,
    this.recommended,
    this.cover,
    this.main,
  });

  factory TicketonShowsEventEntity.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] as List?;
    final images = imagesList?.map((img) => TicketonImage.fromJson(img)).toList();
    return TicketonShowsEventEntity(
      id: json['id']?.toString(),
      name: json['name'],
      genre: json['genre'],
      description: json['description'],
      information: json['information'],
      imageUrl: images?.isNotEmpty == true ? images?.first.url : null,
      duration: int.tryParse(json['duration']?.toString() ?? ''),
      type: json['type'],
      ratingKp: double.tryParse(json['rating_kp']?.toString() ?? ''),
      ratingImdb: double.tryParse(json['rating_imdb']?.toString() ?? ''),
      director: json['director'],
      actors: json['actors'],
      country: json['country'],
      year: json['year'],
      remark: json['remark'],
      images: images,
      video: json['video'],
      soldedCount: json['solded_count']?.toString(),
      recommended: int.tryParse(json['recommended']?.toString() ?? ''),
      cover: json['cover'],
      main: json['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (genre != null) 'genre': genre,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (duration != null) 'duration': duration,
      if (type != null) 'type': type,
      if (ratingKp != null) 'rating_kp': ratingKp,
      if (ratingImdb != null) 'rating_imdb': ratingImdb,
      if (director != null) 'director': director,
      if (actors != null) 'actors': actors,
      if (country != null) 'country': country,
      if (year != null) 'year': year,
      if (remark != null) 'remark': remark,
      if (images != null) 'images': images?.map((img) => img.toJson()).toList(),
      if (video != null) 'video': video,
      if (soldedCount != null) 'solded_count': soldedCount,
      if (recommended != null) 'recommended': recommended,
      if (cover != null) 'cover': cover,
      if (main != null) 'main': main,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        genre,
        description,
        information,
        imageUrl,
        duration,
        type,
        ratingKp,
        ratingImdb,
        director,
        actors,
        country,
        year,
        remark,
        images,
        video,
        soldedCount,
        recommended,
        cover,
        main
      ];
}
