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
  final String bookingDate;
  final int wsId;

  WorkspaceAdded(
    this.bookingDate,
    this.hqId,
    this.wsId,
  );
}

class CreateBooking extends AddBookingEvent {
  final int wsId;
  final int wpId;
  final String bookingDate;

  CreateBooking(
    this.wsId,
    this.wpId,
    this.bookingDate,
  );
}

class CleaningBookingDate extends AddBookingEvent {}
