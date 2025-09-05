import 'package:flutter/material.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/admin/user_management/bloc/user_assessments_bloc.dart';
import 'package:readytogo/Features/admin/user_management/bloc/user_assessments_event.dart';
import 'package:readytogo/Features/admin/user_management/bloc/user_assessments_state.dart';
import 'package:readytogo/Repositories/assessment_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';

// ---- UI constants ----
const kPrimaryBlue = Color(0xFF3B82F6); // left strip + icon color
const kCardBorder = Color(0xFFE7ECFF);
const kLabelColor = Colors.black;
const kValueColor = Colors.black87;

class UserAssessmentsScreen extends StatelessWidget {
  const UserAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAssessmentsBloc>(
      create: (_) => UserAssessmentsBloc(AssessmentRepository()),
      child: Builder(
        builder: (context) {
          // Dispatch the event after the bloc is available in the context
          context.read<UserAssessmentsBloc>().add(FetchUserAssessments());
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "User Assessments",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: DecoratedBox(
              decoration: boxDecoration(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.filter_list),
                        hintText: "Search users...",
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<UserAssessmentsBloc, UserAssessmentsState>(
                      builder: (context, state) {
                        if (state is UserAssessmentsLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is UserAssessmentsLoaded) {
                          final assessments = state.assessments;
                          if (assessments.isEmpty) {
                            return const Center(child: Text('No assessments found'));
                          }
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  itemCount: assessments.length,
                                  itemBuilder: (context, index) {
                                    final assessment = assessments[index];
                                    return UserCard(
                                      assessmentSubmissionId: assessment.assessmentSubmissionId,
                                      name: '${assessment.assesseeFirstName} ${assessment.assesseeLastName}',
                                      email: assessment.assesseeEmail,
                                      type: assessment.assesseeRole,
                                      formTitle: assessment.assessmentTitle,
                                      createdAt: assessment.createdAt,
                                      durationSeconds: assessment.durationSeconds,
                                    );
                                  },
                                ),
                              ),
                              PaginationBar(
                                currentPage: 1,
                                totalPages: 5,
                                onPrev: null,
                                onNext: null,
                              ),
                            ],
                          );
                        } else if (state is UserAssessmentsError) {
                          debugPrint('[UserAssessmentsScreen] Error: ${state.message}');
                          return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.red)));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String assessmentSubmissionId;
  final String name;
  final String email;
  final String type;
  final String formTitle;
  final DateTime createdAt;
  final num? durationSeconds;

  const UserCard({
    super.key,
    required this.assessmentSubmissionId,
    required this.name,
    required this.email,
    required this.type,
    required this.formTitle,
    required this.createdAt,
    this.durationSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kCardBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left blue accent
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: const BoxDecoration(
                color: kPrimaryBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8), // even vertical padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: kLabelColor,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Download CSV',
                      icon: const Icon(
                        Icons.description_outlined,
                        size: 18,
                        color: kPrimaryBlue,
                      ),
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                      onPressed: () async {
                        try {
                          final url = 'http://173.249.27.4:343/api/Assessment/$assessmentSubmissionId/export';
                          final box = GetStorage();
                          final token = box.read('token');
                          final response = await http.get(
                            Uri.parse(url),
                            headers: {
                              if (token != null) 'Authorization': 'Bearer $token',
                            },
                          );
                          if (response.statusCode == 200) {
                            Directory? downloadsDir;
                            if (Platform.isAndroid) {
                              downloadsDir = await getExternalStorageDirectory();
                              final testDir = Directory('/storage/emulated/0/Download');
                              if (await testDir.exists()) {
                                downloadsDir = testDir;
                              }
                            } else if (Platform.isIOS) {
                              downloadsDir = await getApplicationDocumentsDirectory();
                            }
                            final filePath = '${downloadsDir?.path}/assessment_$assessmentSubmissionId.csv';
                            final file = File(filePath);
                            await file.writeAsBytes(response.bodyBytes);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Downloaded CSV to $filePath')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Download failed: ${response.statusCode}')),
                            );
                          }
                        } catch (e, stack) {
                          debugPrint('[UserCard] Download error: $e');
                          debugPrint('[UserCard] StackTrace: $stack');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Download error: $e')),
                          );
                        }
                      },
                    ),
                  ],
                ),
                InfoText(label: "Email", value: email),
                InfoText(label: "Type", value: type),
                InfoText(label: "Form Title", value: formTitle),
                InfoText(label: "Created At", value: createdAt.toString()),
                InfoText(label: "Duration (seconds)", value: durationSeconds?.toString() ?? 'N/A'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(
            color: kLabelColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: kValueColor,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginationBar extends StatelessWidget {
  final int currentPage;   // 1-based
  final int totalPages;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3B82F6);
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onPrev,
            style: OutlinedButton.styleFrom(
              foregroundColor: blue,
              side: const BorderSide(color: blue, width: 1),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Previous'),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Page $currentPage of $totalPages',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: onNext,
            style: OutlinedButton.styleFrom(
              foregroundColor: blue,
              side: const BorderSide(color: blue, width: 1),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
