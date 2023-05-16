part of 'headquarter_cubit.dart';

abstract class HeadquarterState extends Equatable {
  const HeadquarterState();

  @override
  List<Object> get props => [];
}

class HeadquarterInitial extends HeadquarterState {}

class HeadquarterLoaded extends HeadquarterState {
  final List<Headquarter> headquarters;

  HeadquarterLoaded({required this.headquarters});
}

class HeadquarterLoading extends HeadquarterState {}
