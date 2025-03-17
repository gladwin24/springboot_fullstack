import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'services/auth_service.dart';
import 'profile_page.dart'; // Import the profile page
import 'news_detail_page.dart'; // Import the news detail page
import 'services/services_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
      body: Container(
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
            )
                .animate()
                .fadeIn(duration: 600.ms),
            Text(
              'John Doe', // Replace with actual user name
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                            color: Colors.white,
                  ),
            )
                .animate()
                .fadeIn(delay: 200.ms),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, end: 0),

            const SizedBox(height: 24),

              // Quick Actions Section
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 16),

              // Quick Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  _buildQuickActionButton(
                    context,
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    ),
                  ),
                  _buildQuickActionButton(
                    context,
                    icon: Icons.menu,
                    label: 'Services',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ServicesPage()),
                    ),
                ),
              ],
            )
                .animate()
                  .fadeIn(delay: 600.ms)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 24),

              // News Section
            Text(
                'Latest News',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
                .animate()
                  .fadeIn(delay: 800.ms)
                  .slideX(begin: -0.2, end: 0),

            const SizedBox(height: 16),

              // News Cards
              _buildNewsCard(
                context,
                title: 'Important Announcement',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                imageUrl: 'https://picsum.photos/200/300',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsDetailPage(
                      title: 'Important Announcement',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      imageUrl: 'https://picsum.photos/200/300',
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms)
                  .slideX(begin: 0.2, end: 0),

              _buildNewsCard(
                context,
                title: 'Upcoming Events',
                description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                imageUrl: 'https://picsum.photos/200/300',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsDetailPage(
                      title: 'Upcoming Events',
                      description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      imageUrl: 'https://picsum.photos/200/300',
                    ),
                  ),
                ),
              )
                .animate()
                  .fadeIn(delay: 1200.ms)
                  .slideX(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context, {
    required String title,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
        return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
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
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
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

// Home Content Widget
class HomeContent extends StatelessWidget {
  // Sample data for news
  final List<Map<String, dynamic>> news = [
    {
      'title': 'News 1',
      'description': 'This is the detailed description of News 1.',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'News 2',
      'description': 'This is the detailed description of News 2.',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'News 3',
      'description': 'This is the detailed description of News 3.',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'News 4',
      'description': 'This is the detailed description of News 4.',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'News 5',
      'description': 'This is the detailed description of News 5.',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade800,
            Colors.purple.shade600,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar with Institution Logo and Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(
                      Icons.school, // Replace with your institution logo
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Institution Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Latest News Section (Scrollable Like Instagram)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to NewsDetailPage with news data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  title: news[index]['title'],
                                  description: news[index]['description'],
                                  imageUrl: news[index]['image'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.only(right: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      news[index]['image'],
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    news[index]['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Short description...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Event Timeline Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3, // Replace with actual event count
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(
                            index == 0 ? Icons.live_tv : Icons.timer,
                            color: index == 0 ? Colors.red : Colors.blue,
                          ),
                          title: Text(
                            'Event ${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            index == 0
                                ? 'Live Now'
                                : 'Starts in ${index + 1}h ${index * 30}m',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          trailing: Text(
                            '${index + 10}:00 AM',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}