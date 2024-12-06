import 'package:bloc/bloc.dart';
import 'package:flutter_firebase/model/entity_user.dart';
import 'package:meta/meta.dart';

import '../repository/firestore_service.dart';

part 'add_notes_event.dart';
part 'add_notes_state.dart';

class AddNotesBloc extends Bloc<AddNotesEvent, AddNotesState> {
  AddNotesBloc() : super(AddNotesInitial()) {
    on<AddNotesEvent>((event, emit) {
      emit(AddNotesLoading());
      FirestoreService().addRecord(event.user).then((onValue) {
        emit(AddNotesSuccess());
      }).catchError((onError) {
        emit(AddNotesFailure(onError.toString()));
      });
    });
  }
}
