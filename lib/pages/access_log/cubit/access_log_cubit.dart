import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'access_log_state.dart';

class AccessLogCubit extends Cubit<AccessLogState> {
  final MainRepository mainRepository;

  AccessLogCubit(this.mainRepository) : super(AccessLogInitial());

  void getAccessLog() {
    mainRepository.getAccessLog().then((accessLog) {
      emit(AccessLogLoaded(accessLog: accessLog));
    });
  }
}
