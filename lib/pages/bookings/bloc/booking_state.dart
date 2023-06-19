part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingAdded extends BookingState {}

class BookingDateSelected extends BookingState {
  final List<Workspace> workspaces;
  final String bookingDate;
  final int hqId;

  BookingDateSelected({
    required this.bookingDate,
    required this.hqId,
    required this.workspaces,
  });
}

class WorkspaceSelected extends BookingState {
  final List<Workplace> workplaces;
  final int hqId;
  final int wsId;

  WorkspaceSelected({
    required this.wsId,
    required this.hqId,
    required this.workplaces,
  });
}

class BookingsLoaded extends BookingState {
  final List<WpBooking> myBookings;

  BookingsLoaded({
    required this.myBookings,
  });
}

class BookingCreated extends BookingState {}

class BookingDeleted extends BookingState {}

class BookingError extends BookingState {
  final String errorMessage;

  BookingError(this.errorMessage);
}
