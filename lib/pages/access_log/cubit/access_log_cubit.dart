// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:parallel/core/models/access/access.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'access_log_state.dart';

///Utente di destinazione: RECEPTIONIST
class AccessLogCubit extends Cubit<AccessLogState> {
  final MainRepository mainRepository;

  AccessLogCubit(this.mainRepository) : super(AccessLogInitial());

  ///getAccessLog ottiene la lista degli accessi
  ///INPUT: id headquarter, token
  ///OUTPUT: AccessLogLoaded State
  void getAccessLog(int hqId, String token) {
    mainRepository.getAccessLog(hqId, token).then((accessLog) {
      emit(AccessLogLoaded(accessLog: accessLog));
    });
  }

  ///checkInUser effettua il check in per un utente
  ///INPUT: id workspace, id workplace, id prenotazione
  ///OUTPUT: UserCheckIn State | AccessLogError State
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
