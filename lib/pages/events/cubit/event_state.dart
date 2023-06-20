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

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded({required this.events});
}

class MyEventsLoaded extends EventState {
  final List<EventBooking> events;

  MyEventsLoaded({required this.events});
}

class EventsLoading extends EventState {}

class EventBookingDeleted extends EventState {}

class EventError extends EventState {
  final String error;

  EventError(this.error);
}
