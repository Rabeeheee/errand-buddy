import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'escalation_event.dart';
part 'escalation_state.dart';

class EscalationBloc extends Bloc<EscalationEvent, EscalationState> {
  EscalationBloc() : super(EscalationInitial()) {
    on<EscalationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
