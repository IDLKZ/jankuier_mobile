import 'package:equatable/equatable.dart';

abstract class CancelOrDeleteProductOrderState extends Equatable {
  const CancelOrDeleteProductOrderState();

  @override
  List<Object?> get props => [];
}

class CancelOrDeleteProductOrderInitial
    extends CancelOrDeleteProductOrderState {
  const CancelOrDeleteProductOrderInitial();
}

class CancelOrDeleteProductOrderLoading
    extends CancelOrDeleteProductOrderState {
  const CancelOrDeleteProductOrderLoading();
}

class CancelOrDeleteProductOrderSuccess
    extends CancelOrDeleteProductOrderState {
  final bool success;

  const CancelOrDeleteProductOrderSuccess(this.success);

  @override
  List<Object?> get props => [success];
}

class CancelOrDeleteProductOrderError extends CancelOrDeleteProductOrderState {
  final String message;

  const CancelOrDeleteProductOrderError(this.message);

  @override
  List<Object?> get props => [message];
}
