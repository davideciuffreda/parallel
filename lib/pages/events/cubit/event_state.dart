part of 'event_cubit.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded({required this.events});
}

class EvebtsLoading extends EventState {}
