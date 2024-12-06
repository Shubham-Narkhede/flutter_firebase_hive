part of 'add_notes_bloc.dart';

class AddNotesEvent {
  final EntityUser user;

  AddNotesEvent(this.user);

  @override
  List<Object?> get props => [user];
}
