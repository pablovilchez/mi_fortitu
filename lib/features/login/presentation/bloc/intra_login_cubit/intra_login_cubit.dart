import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intra_login_state.dart';

class IntraLoginCubit extends Cubit<IntraLoginState> {
  IntraLoginCubit() : super(IntraLoginInitial());
}
