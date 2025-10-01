import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';

abstract class UpdateCartItemEvent extends Equatable {
  const UpdateCartItemEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCartItemRequested extends UpdateCartItemEvent {
  final UpdateOrRemoveFromCartParameter parameter;

  const UpdateCartItemRequested(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
