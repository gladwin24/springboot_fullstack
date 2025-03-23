import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class NewsService {
  final String baseUrl = 'http://10.0.2.2:8080/api';

  Future<List<News>> getAllNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/news'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<List<News>> getNewsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/news/category/$category'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news by category');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<News> getNewsById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/news/$id'));
      if (response.statusCode == 200) {
        return News.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
} 