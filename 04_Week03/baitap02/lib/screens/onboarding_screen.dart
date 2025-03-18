import 'package:flutter/material.dart';
import '../widgets/onboarding_page.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/splash.png',
      title: 'UTH SmartTasks',
      description: '',
      isSplash: true,
    ),
    OnboardingPage(
      image: 'assets/bro.png',
      title: 'Easy Time Management',
      description: 'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first.',
    ),
    OnboardingPage(
      image: 'assets/bro2.png',
      title: 'Increase Work Effectiveness',
      description: 'Time management and the determination of more important tasks will give your job statistics better and always improve.',
    ),
    OnboardingPage(
      image: 'assets/bro3.png',
      title: 'Reminder Notification',
      description: 'The advantage of this application is that it also provides reminders for you so you don\'t forget to keep doing your assignments well and according to the time you have set.',
      isLast: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home screen or main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            if (_currentPage > 0 && _currentPage < _pages.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_pages.length - 1);
                    },
                    child: const Text('skip', 
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              
            // Progress indicator
            if (_currentPage > 0)
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: List.generate(
                      _pages.length - 1,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: _currentPage - 1 == index ? Colors.blue : Colors.blue.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),
            
            // Navigation buttons
            if (_currentPage > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: _currentPage > 1 
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    // Back button (shown only on pages 2 and 3)
                    if (_currentPage > 1)
                      Container(
                        width: 48,
                        height: 48, 
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: _goToPreviousPage,
                        ),
                      ),
                    
                    // Next/Get Started button
                    SizedBox(
                      width: _currentPage < _pages.length - 1 ? 200 : 240,
                      child: ElevatedButton(
                        onPressed: _goToNextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}