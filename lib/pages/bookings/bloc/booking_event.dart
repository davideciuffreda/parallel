part of 'booking_bloc.dart';

abstract class BookingEvent {}

class BookingDateAdded extends BookingEvent {
  final int hqId;
  final String bookingDate;

  BookingDateAdded(
    this.hqId,
    this.bookingDate,
  );
}

class WorkspaceAdded extends BookingEvent {
  final int hqId;
  final String bookingDate;
  final int wsId;

  WorkspaceAdded(
    this.bookingDate,
    this.hqId,
    this.wsId,
  );
}

class CreateBooking extends BookingEvent {
  final int wsId;
  final int wpId;
  final String bookingDate;

  CreateBooking(
    this.wsId,
    this.wpId,
    this.bookingDate,
  );
}

class CleaningBookingDate extends BookingEvent {}

class GetAllMyWpBookings extends BookingEvent {}

class DeleteBooking extends BookingEvent {
  final int wsId;
  final int wpId;
  final int bkId;

  DeleteBooking(
    this.wsId,
    this.wpId,
    this.bkId,
  );
}
