import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/auth_service.dart';
import 'services/event_service.dart';
import 'services/news_service.dart';
import 'profile_page.dart'; // Import the profile page
import 'news_detail_page.dart'; // Import the news detail page
import 'services/services_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ServicesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_outlined),
            selectedIcon: Icon(Icons.menu),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final EventService _eventService = EventService();
  final NewsService _newsService = NewsService();
  List<Event> _upcomingEvents = [];
  List<News> _latestNews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final events = await _eventService.getUpcomingEvents();
      final news = await _newsService.getAllNews();
      if (mounted) {
        setState(() {
          _upcomingEvents = events;
          _latestNews = news;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthService>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ).animate().fadeIn(duration: 600.ms),
                            Text(
                              'John Doe', // Replace with actual user name
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ).animate().fadeIn(delay: 200.ms),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

                      const SizedBox(height: 24),

                      // Events Section
                      Text(
                        'Upcoming Events',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),

                      const SizedBox(height: 16),

                      // Events List
                      if (_upcomingEvents.isEmpty)
                        Center(
                          child: Text(
                            'No upcoming events',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                      else
                        ..._upcomingEvents.map((event) => _buildEventCard(
                              context,
                              event: event,
                            ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2, end: 0)),

                      const SizedBox(height: 24),

                      // News Section
                      Text(
                        'Latest News',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 1000.ms).slideX(begin: -0.2, end: 0),

                      const SizedBox(height: 16),

                      // News Cards
                      if (_latestNews.isEmpty)
                        Center(
                          child: Text(
                            'No news available',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                      else
                        ..._latestNews.map((news) => _buildNewsCard(
                              context,
                              news: news,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(
                                    title: news.title,
                                    description: news.description,
                                    imageUrl: news.imageUrl,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(delay: 1200.ms).slideX(begin: 0.2, end: 0)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required Event event,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to event details
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${event.dateTime.hour}:${event.dateTime.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        event.location,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context, {
    required News news,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: news.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (news.category.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      news.category,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    news.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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