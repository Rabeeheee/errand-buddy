import 'package:errand_buddy/features/members/presentation/bloc/member_bloc.dart';
import 'package:errand_buddy/features/members/presentation/bloc/member_event.dart';
import 'package:errand_buddy/features/members/presentation/widgets/members_view.dart';
import 'package:errand_buddy/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembersBloc(
        assigneeDataSource: TaskRemoteDataSourceImpl(
          firestore: FirebaseFirestore.instance,
        ),
      )..add(LoadMembers()),
      child: const MembersView(),
    );
  }
}