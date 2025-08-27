import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final int id;
  final String filename;
  final String filePath;
  final int fileSize;
  final String contentType;
  final bool isRemote;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FileEntity({
    required this.id,
    required this.filename,
    required this.filePath,
    required this.fileSize,
    required this.contentType,
    required this.isRemote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileEntity.fromJson(Map<String, dynamic> json) {
    return FileEntity(
      id: json['id'],
      filename: json['filename'],
      filePath: json['file_path'],
      fileSize: json['file_size'],
      contentType: json['content_type'],
      isRemote: json['is_remote'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filename': filename,
      'file_path': filePath,
      'file_size': fileSize,
      'content_type': contentType,
      'is_remote': isRemote,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        filename,
        filePath,
        fileSize,
        contentType,
        isRemote,
        createdAt,
        updatedAt,
      ];
}

class FileUploadResponseEntity extends FileEntity {
  final String url;

  const FileUploadResponseEntity({
    required super.id,
    required super.filename,
    required super.filePath,
    required super.fileSize,
    required super.contentType,
    required super.isRemote,
    required super.createdAt,
    required super.updatedAt,
    required this.url,
  });

  factory FileUploadResponseEntity.fromJson(Map<String, dynamic> json) {
    return FileUploadResponseEntity(
      id: json['id'],
      filename: json['filename'],
      filePath: json['file_path'],
      fileSize: json['file_size'],
      contentType: json['content_type'],
      isRemote: json['is_remote'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      url: json['url'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['url'] = url;
    return map;
  }

  @override
  List<Object?> get props => super.props..add(url);
}
