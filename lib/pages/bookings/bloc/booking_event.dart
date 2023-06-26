// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'booking_bloc.dart';

abstract class BookingEvent {}

///Evento che segnala che la data di prenotazione è stata scelta dall'utente
class BookingDateAdded extends BookingEvent {
  final int hqId;
  final String bookingDate;

  BookingDateAdded(this.hqId, this.bookingDate);
}

///Evento che segnala che il workspace è stato scelto dall'utente
class WorkspaceAdded extends BookingEvent {
  final int hqId;
  final String bookingDate;
  final int wsId;

  WorkspaceAdded(this.bookingDate, this.hqId, this.wsId);
}

///Evento che segnala che la data di prenotazione è stata scelta dall'utente
class CreateBooking extends BookingEvent {
  final int wsId;
  final int wpId;
  final String bookingDate;

  CreateBooking(this.wsId, this.wpId, this.bookingDate);
}

class CleaningBookingDate extends BookingEvent {}

class GetAllMyWpBookings extends BookingEvent {}

///Evento che segnala la volontà di cancellare una prenotazione
class DeleteBooking extends BookingEvent {
  final int wsId;
  final int wpId;
  final int bkId;

  DeleteBooking(this.wsId, this.wpId, this.bkId);
}
