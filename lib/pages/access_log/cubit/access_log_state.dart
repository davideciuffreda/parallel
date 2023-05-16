part of 'access_log_cubit.dart';

abstract class AccessLogState extends Equatable {
  const AccessLogState();

  @override
  List<Object> get props => [];
}

class AccessLogInitial extends AccessLogState {}

class AccessLogLoading extends AccessLogState {}

class AccessLogLoaded extends AccessLogState {
  final List<Access> accessLog;

  AccessLogLoaded({required this.accessLog});
}
