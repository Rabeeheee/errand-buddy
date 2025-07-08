import 'package:equatable/equatable.dart';

abstract class MembersEvent extends Equatable {
  const MembersEvent();
  @override
  List<Object?> get props => [];
}

class LoadMembers extends MembersEvent {}