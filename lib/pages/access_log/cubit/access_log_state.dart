// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'access_log_cubit.dart';

abstract class AccessLogState {}

class AccessLogInitial extends AccessLogState {}

class AccessLogLoading extends AccessLogState {}

class UserCheckIn extends AccessLogState {}

class AccessLogLoaded extends AccessLogState {
  final List<Access> accessLog;

  AccessLogLoaded({required this.accessLog});
}

class AccessLogError extends AccessLogState {
  final String error;

  AccessLogError({required this.error});
}
