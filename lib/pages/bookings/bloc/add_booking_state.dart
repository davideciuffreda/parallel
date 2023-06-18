part of 'add_booking_bloc.dart';

abstract class AddBookingState {}

class AddBookingInitial extends AddBookingState {}

class BookingAdded extends AddBookingState {}

class BookingDateSelected extends AddBookingState {
  final List<Workspace> workspaces;
  final int hqId;

  BookingDateSelected({
    required this.hqId,
    required this.workspaces,
  });
}

class WorkspaceSelected extends AddBookingState {
  final List<Workplace> workplaces;
  final int hqId;
  final int wsId;

  WorkspaceSelected({
    required this.wsId,
    required this.hqId,
    required this.workplaces,
  });
}

class AddBookingError extends AddBookingState {
  final String errorMessage;

  AddBookingError(this.errorMessage);
}
