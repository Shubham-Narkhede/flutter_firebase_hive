part of 'add_notes_bloc.dart';

@immutable
sealed class AddNotesState {}

final class AddNotesInitial extends AddNotesState {}

final class AddNotesLoading extends AddNotesState {}

final class AddNotesFailure extends AddNotesState {
  String error;

  AddNotesFailure(this.error);
}

final class AddNotesSuccess extends AddNotesState {}
