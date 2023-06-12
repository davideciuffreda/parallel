part of 'add_booking_bloc.dart';

abstract class AddBookingState {}

class AddBookingInitial extends AddBookingState {}

class BookingAdded extends AddBookingState {}

class BookingDateSelected extends AddBookingState {}

class AddBookingError extends AddBookingState {
  final String errorMessage;

  AddBookingError(this.errorMessage);
}
