import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readytogo/Model/assessment_model.dart';
import 'package:readytogo/Constants/api_constants.dart';
import 'package:get_storage/get_storage.dart';

class AssessmentRepository {
  Future<List<AssessmentModel>> fetchAssessments() async {
    final url = 'http://173.249.27.4:343/api/Assessment/list';
    print('[AssessmentRepository] GET $url');
    final box = GetStorage();
    final token = box.read('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    print('[AssessmentRepository] Response status: ${response.statusCode}');
    print('[AssessmentRepository] Response body: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AssessmentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assessments');
    }
  }
}
