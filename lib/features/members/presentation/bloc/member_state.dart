part of 'member_bloc.dart';

sealed class MemberState extends Equatable {
  const MemberState();
  
  @override
  List<Object> get props => [];
}

final class MemberInitial extends MemberState {}
