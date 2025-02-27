import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'supa_register_event.dart';
part 'supa_register_state.dart';

class SupaRegisterBloc extends Bloc<SupaRegisterEvent, SupaRegisterState> {
  SupaRegisterBloc() : super(SupaRegisterInitial()) {
    on<SupaRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
