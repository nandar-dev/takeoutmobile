import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(1)) {
    on<SetLanguageEvent>((event, emit) {
      emit(LanguageState(event.languageId));
    });
  }
}
