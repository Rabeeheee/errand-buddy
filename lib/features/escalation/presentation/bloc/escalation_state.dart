part of 'escalation_bloc.dart';

sealed class EscalationState extends Equatable {
  const EscalationState();
  
  @override
  List<Object> get props => [];
}

final class EscalationInitial extends EscalationState {}
