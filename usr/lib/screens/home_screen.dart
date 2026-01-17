import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../data/mock_data.dart';
import '../widgets/video_feed_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to go behind the bottom nav
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Feed Content
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: MockData.videos.length,
            itemBuilder: (context, index) {
              return VideoFeedItem(post: MockData.videos[index]);
            },
          ),

          // Top Navigation (Following | For You)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Following',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 1,
                  height: 15,
                  color: Colors.white24,
                ),
                const SizedBox(width: 20),
                Text(
                  'For You',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 8,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // Floating Action Button for Upload
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement upload flow
        },
        backgroundColor: const Color(0xFF00F2EA), // Electric Cyan
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: GlassmorphicContainer(
        width: double.infinity,
        height: 80,
        borderRadius: 0,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.5),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 28),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(width: 40), // Spacer for FAB
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded, size: 28),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
