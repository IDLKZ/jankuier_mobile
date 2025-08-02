import 'package:equatable/equatable.dart';

class LeaderEntry extends Equatable {
  final int position;
  final String name;
  final String iconAsset;

  const LeaderEntry({
    required this.position,
    required this.name,
    required this.iconAsset,
  });

  @override
  List<Object?> get props => [position, name, iconAsset];
}