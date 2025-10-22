import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vaccine.dart';
import '../models/dose.dart';

class ApiService {
  // For web browser, use localhost
  // For Android emulator, use 10.0.2.2 instead of localhost
  // For physical device, use your computer's IP address
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Headers
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Vaccine API Methods
  static Future<List<Vaccine>> getVaccines() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/vaccines'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> vaccinesJson = data['data'];
          return vaccinesJson.map((json) => Vaccine.fromJson(json)).toList();
        }
      }
      throw Exception('Failed to load vaccines');
    } catch (e) {
      throw Exception('Error fetching vaccines: $e');
    }
  }

  static Future<Vaccine> getVaccineById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/vaccines/$id'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Vaccine.fromJson(data['data']);
        }
      }
      throw Exception('Failed to load vaccine');
    } catch (e) {
      throw Exception('Error fetching vaccine: $e');
    }
  }

  static Future<Vaccine> createVaccine(Vaccine vaccine) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/vaccines'),
        headers: _headers,
        body: json.encode(vaccine.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Vaccine.fromJson(data['data']);
        }
      }
      throw Exception('Failed to create vaccine');
    } catch (e) {
      throw Exception('Error creating vaccine: $e');
    }
  }

  static Future<Vaccine> updateVaccine(String id, Vaccine vaccine) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/vaccines/$id'),
        headers: _headers,
        body: json.encode(vaccine.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Vaccine.fromJson(data['data']);
        }
      }
      throw Exception('Failed to update vaccine');
    } catch (e) {
      throw Exception('Error updating vaccine: $e');
    }
  }

  static Future<void> deleteVaccine(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/vaccines/$id'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete vaccine');
      }
    } catch (e) {
      throw Exception('Error deleting vaccine: $e');
    }
  }

  // Dose API Methods
  static Future<List<Dose>> getDoses() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/doses'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> dosesJson = data['data'];
          return dosesJson.map((json) => Dose.fromJson(json)).toList();
        }
      }
      throw Exception('Failed to load doses');
    } catch (e) {
      throw Exception('Error fetching doses: $e');
    }
  }

  static Future<Dose> getDoseById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/doses/$id'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Dose.fromJson(data['data']);
        }
      }
      throw Exception('Failed to load dose');
    } catch (e) {
      throw Exception('Error fetching dose: $e');
    }
  }

  static Future<List<Dose>> getDosesByVaccineId(String vaccineId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/doses/vaccine/$vaccineId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> dosesJson = data['data'];
          return dosesJson.map((json) => Dose.fromJson(json)).toList();
        }
      }
      throw Exception('Failed to load doses for vaccine');
    } catch (e) {
      throw Exception('Error fetching doses for vaccine: $e');
    }
  }

  static Future<Dose> createDose(Dose dose) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/doses'),
        headers: _headers,
        body: json.encode(dose.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Dose.fromJson(data['data']);
        }
      }
      throw Exception('Failed to create dose');
    } catch (e) {
      throw Exception('Error creating dose: $e');
    }
  }

  static Future<Dose> updateDose(String id, Dose dose) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/doses/$id'),
        headers: _headers,
        body: json.encode(dose.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Dose.fromJson(data['data']);
        }
      }
      throw Exception('Failed to update dose');
    } catch (e) {
      throw Exception('Error updating dose: $e');
    }
  }

  static Future<void> deleteDose(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/doses/$id'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete dose');
      }
    } catch (e) {
      throw Exception('Error deleting dose: $e');
    }
  }

  // Health check
  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
