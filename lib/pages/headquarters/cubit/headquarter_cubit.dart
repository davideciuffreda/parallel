import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/headquarter.dart';

import 'package:parallel/core/repositories/main_repository.dart';

part 'headquarter_state.dart';

class HeadquarterCubit extends Cubit<HeadquarterState> {
  final MainRepository mainRepository;

  HeadquarterCubit(this.mainRepository) : super(HeadquarterInitial());

  void getHeadquarters() {
    mainRepository.getHeadquarters().then((headquarters) {
      emit(HeadquarterLoaded(headquarters: headquarters));
    });
  }

  void getHeadquarterById(int id) {
    mainRepository.getHeadquarterById(id).then((hq) {
      emit(HeadquarterDetailLoaded(hq: hq));
    });
  }
}
