part of 'add_booking_bloc.dart';

abstract class AddBookingEvent {}

class BookingDateAdded extends AddBookingEvent {
  final int hqId;
  final String bookingDate;

  BookingDateAdded(
    this.hqId,
    this.bookingDate,
  );
}

class WorkspaceAdded extends AddBookingEvent {
  final int hqId;
  final int wsId;

  WorkspaceAdded(
    this.hqId,
    this.wsId,
  );
}

class CleaningBookingDate extends AddBookingEvent {}
