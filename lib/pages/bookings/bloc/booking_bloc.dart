import 'package:bloc/bloc.dart';
import 'package:parallel/core/models/workplace.dart';
import 'package:parallel/core/models/workspace.dart';
import 'package:parallel/core/models/wpBooking.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final MainRepository mainRepository;

  BookingBloc(this.mainRepository) : super(BookingInitial()) {
    on<BookingDateAdded>((event, emit) async {
      if (event.bookingDate == '') {
        emit(BookingError("La data selezionata non è valida!"));
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
          emit(BookingError(
              'Probabilmente esiste già una prenotazione a tuo carico per la' +
                  ' data selezionata oppure la postazione non è disponibile!'));
        }
      });
    });

    on<GetAllMyWpBookings>((event, emit) async {
      await mainRepository.getBookingsByToken().then((myBookings) {
        emit(BookingsLoaded(myBookings: myBookings));
      });
    });

    on<DeleteBooking>((event, emit) async {
      await mainRepository
          .deleteBooking(event.wsId, event.wpId, event.bkId)
          .then((response) {
        if (response == 'booking_deleted') {
          emit(BookingDeleted());
        } else {
          emit(
            BookingError("Non è stato possibile cancellare la prenotazione"),
          );
        }
      });
    });

    on<CleaningBookingDate>((event, emit) {
      emit(BookingInitial());
    });
  }
}
