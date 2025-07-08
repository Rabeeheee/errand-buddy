import 'package:errand_buddy/features/members/presentation/bloc/member_bloc.dart';
import 'package:errand_buddy/features/members/presentation/bloc/member_event.dart';
import 'package:errand_buddy/features/members/presentation/bloc/member_state.dart';
import 'package:errand_buddy/features/members/presentation/widgets/members_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: BlocBuilder<MembersBloc, MembersState>(
        builder: (context, state) {
          if (state is MembersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MembersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MembersBloc>().add(LoadMembers());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is MembersLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.membersWithStats.length,
                itemBuilder: (context, index) {
                  final memberWithStats = state.membersWithStats[index];
                  return MemberCard(
                    member: memberWithStats.member,
                    stats: memberWithStats.stats,
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text('No members found'),
          );
        },
      ),
    );
  }
}