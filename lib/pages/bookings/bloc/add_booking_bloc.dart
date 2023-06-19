import 'package:bloc/bloc.dart';
import 'package:parallel/core/models/workplace.dart';
import 'package:parallel/core/models/workspace.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'add_booking_event.dart';
part 'add_booking_state.dart';

class AddBookingBloc extends Bloc<AddBookingEvent, AddBookingState> {
  final MainRepository mainRepository;

  AddBookingBloc(this.mainRepository) : super(AddBookingInitial()) {
    on<BookingDateAdded>((event, emit) async {
      if (event.bookingDate == '2023-06-13' || event.bookingDate == '') {
        emit(AddBookingError("La data selezionata non è valida!"));
      } else {
        await mainRepository
            .getWorkspacesByDate(event.hqId, event.bookingDate)
            .then((workspaces) {
          emit(BookingDateSelected(
            bookingDate: event.bookingDate,
            workspaces: workspaces,
            hqId: event.hqId,
          ));
        });
      }
    });

    on<WorkspaceAdded>((event, emit) async {
      await mainRepository
          .getWorkplacesByWorkspace(event.hqId, event.wsId)
          .then((workplaces) {
        emit(WorkspaceSelected(
          wsId: event.wsId,
          hqId: event.hqId,
          workplaces: workplaces,
        ));
      });
    });

    on<CreateBooking>((event, emit) async {
      await mainRepository
          .createBooking(event.wsId, event.wpId, event.bookingDate)
          .then((booking) {
        if (booking.id != -1) {
          emit(BookingCreated());
        } else {
          emit(AddBookingError(
              "Probabilmente esiste già una prenotazione a tuo carico per la data selezionata!"));
        }
      });
    });

    on<CleaningBookingDate>((event, emit) {
      emit(AddBookingInitial());
    });
  }
}
