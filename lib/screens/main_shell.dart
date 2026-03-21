import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'practice_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Tab indices: 0=Home, 1=Library, 2=Upload(special), 3=Practice, 4=Profile
  int _selectedIndex = 0;

  // Maps tab index → IndexedStack position (skipping Upload slot 2)
  int get _stackIndex {
    if (_selectedIndex == 0) return 0;
    if (_selectedIndex == 1) return 1;
    if (_selectedIndex == 3) return 2;
    if (_selectedIndex == 4) return 3;
    return 0;
  }

  void _onTabTap(int index) async {
    if (index == 2) {
      final uploaded = await Navigator.pushNamed(context, '/upload');
      if (uploaded == true && mounted) {
        setState(() => _selectedIndex = 1); // switch to Library tab
      }
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: IndexedStack(
        index: _stackIndex,
        children: const [
          HomeScreen(),
          LibraryScreen(),
          PracticeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.menu_book_outlined, 'label': 'Library'},
      {'icon': null, 'label': 'Upload'},
      {'icon': Icons.psychology_outlined, 'label': 'Practice'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D1117),
        border: Border(top: BorderSide(color: Color(0xFF1E2A3A), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  if (index == 2) return const SizedBox(width: 64);
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () => _onTabTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            items[index]['icon'] as IconData,
                            color: isSelected
                                ? const Color(0xFF6C63FF)
                                : const Color(0xFF4A5568),
                            size: 26,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            items[index]['label'] as String,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFF6C63FF)
                                  : const Color(0xFF4A5568),
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              GestureDetector(
                onTap: () => _onTabTap(2),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
