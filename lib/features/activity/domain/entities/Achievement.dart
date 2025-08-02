import 'package:equatable/equatable.dart';

class Achievement extends Equatable {
  final String title;
  final String iconAsset;

  const Achievement({required this.title, required this.iconAsset});

  @override
  List<Object?> get props => [title, iconAsset];
}