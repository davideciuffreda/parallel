import 'package:bloc/bloc.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'access_log_state.dart';

class AccessLogCubit extends Cubit<AccessLogState> {
  final MainRepository mainRepository;

  AccessLogCubit(this.mainRepository) : super(AccessLogInitial());

  void getAccessLog(int hqId, String token) {
    mainRepository.getAccessLog(hqId, token).then((accessLog) {
      emit(AccessLogLoaded(accessLog: accessLog));
    });
  }

  void checkInUser(int wsId, int wpId, int bkId) {
    mainRepository.checkInUser(wsId, wpId, bkId).then((value) {
      if (value == 200) {
        emit(UserCheckIn());
      } else {
        emit(AccessLogError(error: "Operazione non eseguita, riprovare!"));
      }
    });
  }
}
