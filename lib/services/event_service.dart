import 'dart:convert';
import 'package:http/http.dart' as http;

class Event {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'],
      imageUrl: json['imageUrl'] ?? '',
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class EventService {
  final String baseUrl = 'http://10.0.2.2:8080/api';

  Future<List<Event>> getAllEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/events'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<List<Event>> getUpcomingEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/events/upcoming'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load upcoming events');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Event> getEventById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/events/$id'));
      if (response.statusCode == 200) {
        return Event.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load event');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
} 