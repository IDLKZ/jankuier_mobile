import 'package:equatable/equatable.dart';

class TicketonTicketCheckParameter extends Equatable {
  final int ticketOrderId;
  final String ticketId;

  const TicketonTicketCheckParameter({
    required this.ticketOrderId,
    required this.ticketId,
  });

  @override
  List<Object?> get props => [ticketOrderId, ticketId];
}