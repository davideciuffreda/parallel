// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'headquarter_cubit.dart';

abstract class HeadquarterState extends Equatable {
  const HeadquarterState();

  @override
  List<Object> get props => [];
}

class HeadquarterInitial extends HeadquarterState {}

class HeadquarterFavorite extends HeadquarterState {}

class HeadquarterLoaded extends HeadquarterState {
  final List<Headquarter> headquarters;

  HeadquarterLoaded({required this.headquarters});
}

class HeadquarterDetailLoaded extends HeadquarterState {
  final Headquarter hq;

  HeadquarterDetailLoaded({required this.hq});
}

class HeadquarterError extends HeadquarterState {
  final String error;

  HeadquarterError(this.error);
}

class HeadquarterLoading extends HeadquarterState {}
