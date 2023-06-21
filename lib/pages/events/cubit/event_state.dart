part of 'event_cubit.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventCreated extends EventState {}

class EventPresenceSetted extends EventState {}

class EventDeleted extends EventState {}

class EventCanceled extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded({required this.events});
}

class MyEventsLoaded extends EventState {
  final List<EventBooking> events;

  MyEventsLoaded({required this.events});
}

class EventsLoading extends EventState {}

class EventHqSelected extends EventState {
  final int hqId;

  EventHqSelected(this.hqId);
}

class EventBookingDeleted extends EventState {}

class EventError extends EventState {
  final String error;

  EventError(this.error);
}

class EventHeadquartersByCompanyLoaded extends EventState {
  final List<HeadquarterCompany> headquarters;

  EventHeadquartersByCompanyLoaded(this.headquarters);
}
