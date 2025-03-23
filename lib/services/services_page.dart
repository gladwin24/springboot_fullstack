import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'appointment_page.dart'; // Import the appointment page
import 'accommodations_page.dart'; // Import the accommodations page
import 'hall_booking.dart'; // Import the hall booking page
import 'payments.dart'; // Import the payments page
import 'ticket_booking.dart'; // Import the ticket booking page
import 'canteen_page.dart'; // Import the canteen page
import 'transportation.dart'; // Import the transportation page

class ServicesPage extends StatelessWidget {
  // List of services
  static const List<Map<String, dynamic>> services = [
    {
      'title': 'Appointment',
      'icon': Icons.calendar_today,
      'color': Color(0xFF007AFF),
      'description': 'Book appointments with faculty or staff.',
      'gradient': [Color(0xFF007AFF), Color(0xFF0055B3)],
      'image': 'https://via.placeholder.com/300?text=Appointment',
    },
    {
      'title': 'Accommodations',
      'icon': Icons.hotel,
      'color': Color(0xFF00C853),
      'description': 'View and book accommodations.',
      'gradient': [Color(0xFF00C853), Color(0xFF009624)],
      'image': 'https://via.placeholder.com/300?text=Accommodations',
    },
    {
      'title': 'Hall Booking',
      'icon': Icons.meeting_room,
      'color': Color(0xFFFF9500),
      'description': 'Book halls for events and meetings.',
      'gradient': [Color(0xFFFF9500), Color(0xFFCC7700)],
      'image': 'https://via.placeholder.com/300?text=Hall+Booking',
    },
    {
      'title': 'Payments',
      'icon': Icons.payment,
      'color': Color(0xFF5856D6),
      'description': 'Make and manage payments.',
      'gradient': [Color(0xFF5856D6), Color(0xFF4644AB)],
      'image': 'https://via.placeholder.com/300?text=Payments',
    },
    {
      'title': 'Ticket Booking',
      'icon': Icons.confirmation_number,
      'color': Color(0xFFFF3B30),
      'description': 'Book tickets for events.',
      'gradient': [Color(0xFFFF3B30), Color(0xFFCC2F26)],
      'image': 'https://via.placeholder.com/300?text=Ticket+Booking',
    },
    {
      'title': 'Canteen',
      'icon': Icons.restaurant,
      'color': Color(0xFF32ADE6),
      'description': 'Order food and view menu.',
      'gradient': [Color(0xFF32ADE6), Color(0xFF288BB8)],
      'image': 'https://via.placeholder.com/300?text=Canteen',
    },
    {
      'title': 'Transportation',
      'icon': Icons.directions_bus,
      'color': Color(0xFFAF52DE),
      'description': 'View bus schedules and routes.',
      'gradient': [Color(0xFFAF52DE), Color(0xFF8C42B2)],
      'image': 'https://via.placeholder.com/300?text=Transportation',
    },
  ];

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What can we help you with?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                'Choose from our range of services',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideX(begin: -0.2, end: 0),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceCard(context, service, index);
                },
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, Map<String, dynamic> service, int index) {
    return Card(
      elevation: 0,
      shadowColor: service['color'].withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _navigateToService(context, service['title']),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: service['gradient'],
            ),
          ),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: service['image'],
                    fit: BoxFit.cover,
                    color: Colors.white.withOpacity(0.1),
                    colorBlendMode: BlendMode.overlay,
                    placeholder: (context, url) => Container(
                      color: service['color'].withOpacity(0.3),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: service['color'].withOpacity(0.3),
                      child: Icon(service['icon'], color: Colors.white.withOpacity(0.2), size: 48),
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      size: 40,
                      color: Colors.white,
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scale(
                          duration: 2000.ms,
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                        )
                        .then()
                        .scale(
                          duration: 2000.ms,
                          begin: const Offset(1.1, 1.1),
                          end: const Offset(1, 1),
                        ),
                    const SizedBox(height: 16),
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .slideY(begin: 0.2, end: 0);
  }

  // Navigate to the respective service page
  void _navigateToService(BuildContext context, String serviceTitle) {
    Widget page;
    switch (serviceTitle) {
      case 'Appointment':
        page = AppointmentPage();
        break;
      case 'Accommodations':
        page = AccommodationsPage();
        break;
      case 'Hall Booking':
        page = const HallBookingPage();
        break;
      case 'Payments':
        page = const PaymentsPage();
        break;
      case 'Ticket Booking':
        page = const TicketBookingPage();
        break;
      case 'Canteen':
        page = const CanteenPage();
        break;
      case 'Transportation':
        page = const TransportationPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}