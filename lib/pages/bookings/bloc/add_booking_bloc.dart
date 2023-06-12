import 'package:bloc/bloc.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'add_booking_event.dart';
part 'add_booking_state.dart';

class AddBookingBloc extends Bloc<AddBookingEvent, AddBookingState> {
  final MainRepository mainRepository;

  AddBookingBloc(this.mainRepository) : super(AddBookingInitial()) {
    on<BookingDateAdded>((event, emit) {
      if (event.bookingDate == '2023-06-13' || event.bookingDate == '') {
        emit(AddBookingError("La data selezionata non è valida!"));
      } else {
        emit(BookingDateSelected());
      }
    });

    on<CleaningBookingDate>((event, emit) {
      emit(AddBookingInitial());
    });
  }
}
