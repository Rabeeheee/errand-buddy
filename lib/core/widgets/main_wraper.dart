import 'package:flutter/material.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:errand_buddy/features/tasks/presentation/pages/tasks_page.dart';
import 'package:errand_buddy/features/members/presentation/pages/member_page.dart';
import 'package:errand_buddy/features/escalation/presentation/pages/escalation_page.dart';
import 'package:errand_buddy/features/profile/presentation/pages/profile_page.dart';
import 'package:go_router/go_router.dart'; // Add this import

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  
  const MainWrapper({
    Key? key,
    this.initialIndex = 1, // Default to Tasks tab
  }) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;
  late PageController _pageController;

  final List<Widget> _screens = [
    const MembersPage(),
    const TasksPage(),
    const EscalationPage(),
    const ProfilePage(),
  ];

  final List<String> _titles = [
    'Members',
    'Tasks',
    'Escalations',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      floatingActionButton: _currentIndex == 1 ? _buildFloatingActionButton(context) : null,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        _titles[_currentIndex],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
       color: Colors.blue[200],
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.blue)
      ),
      child: FloatingActionButton(
        onPressed: () => _navigateToAddTaskPage(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  void _navigateToAddTaskPage(BuildContext context) {
    context.push('/add-task');
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}