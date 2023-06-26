// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/headquarter/headquarter.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'headquarter_state.dart';

///Utente di destinazione: EMPLOYEE, COMPANY_MANAGER
class HeadquarterCubit extends Cubit<HeadquarterState> {
  final MainRepository mainRepository;

  HeadquarterCubit(this.mainRepository) : super(HeadquarterInitial());

  ///getHeadquarters ottiene la lista degli headquarters
  ///INPUT: -
  ///OUTPUT: HeadquarterLoaded State
  void getHeadquarters() {
    mainRepository.getHeadquarters().then((headquarters) {
      emit(HeadquarterLoaded(headquarters: headquarters));
    });
  }

  ///getHeadquarterById ottiene i dettagli di un headquarter
  ///INPUT: id headquarter
  ///OUTPUT: HeadquarterDetailLoaded State
  void getHeadquarterById(int id) {
    mainRepository.getHeadquarterById(id).then((hq) {
      emit(HeadquarterDetailLoaded(hq: hq));
    });
  }
}
