part of 'add_booking_bloc.dart';

abstract class AddBookingEvent {}

class BookingDateAdded extends AddBookingEvent {
  final String bookingDate;

  BookingDateAdded(
    this.bookingDate,
  );
}

class CleaningBookingDate extends AddBookingEvent {}
