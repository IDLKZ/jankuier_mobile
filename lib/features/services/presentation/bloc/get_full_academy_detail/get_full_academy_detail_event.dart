import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class GetFullAcademyDetailEvent extends Equatable {}

class GetFullAcademyEvent extends GetFullAcademyDetailEvent {
  final int academyId;
  GetFullAcademyEvent(this.academyId);
  @override
  List<Object?> get props => [academyId];
}