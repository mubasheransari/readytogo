import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readytogo/Model/assessment_model.dart';
import 'package:readytogo/Constants/api_constants.dart';

class AssessmentRepository {
  Future<List<AssessmentModel>> fetchAssessments() async {
    final url = 'http://${ApiConstants.baseDomain}/${ApiConstants.apiPrefix}/assessment/list';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AssessmentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assessments');
    }
  }
}
