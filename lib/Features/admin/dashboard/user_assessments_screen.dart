import 'package:flutter/material.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/admin/dashboard/bloc/user_assessments_bloc.dart';
import 'package:readytogo/Features/admin/dashboard/bloc/user_assessments_event.dart';
import 'package:readytogo/Features/admin/dashboard/bloc/user_assessments_state.dart';
import 'package:readytogo/Repositories/assessment_repository.dart';
import 'package:readytogo/Model/assessment_model.dart';
// import 'package:readytogo/Features/admin/dashboard/admin_dashboard_screen.dart';

class UserAssessmentsScreen extends StatelessWidget {
  const UserAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserAssessmentsBloc(AssessmentRepository())..add(FetchUserAssessments()),
      child: Scaffold(
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
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: assessments.length,
                        itemBuilder: (context, index) {
                          final assessment = assessments[index];
                          return UserCard(
                            id: assessment.assesseeUserId,
                            name: '${assessment.assesseeFirstName} ${assessment.assesseeLastName}',
                            email: assessment.assesseeEmail,
                            type: assessment.assesseeRole,
                            formTitle: assessment.assessmentTitle,
                            createdAt: assessment.createdAt,
                            durationSeconds: assessment.durationSeconds,
                          );
                        },
                      );
                    } else if (state is UserAssessmentsError) {
                      debugPrint('[UserAssessmentsScreen] Error: ${state.message}');
                      return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.red)));
                    }
                    return const SizedBox();
                  },
                ),
              ),
              // Pagination UI can be added here if needed
            ],
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String id;
  final String name;
  final String email;
  final String type;
  final String formTitle;
  final DateTime createdAt;
  final num? durationSeconds;

  const UserCard({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.formTitle,
    required this.createdAt,
    this.durationSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFDEE2FF), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoText(label: "Assessee ID", value: id),
                IconButton(
                  icon: const Icon(Icons.download, size: 18, color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
            InfoText(label: "Name", value: name),
            InfoText(label: "Email", value: email),
            InfoText(label: "Role", value: type),
            InfoText(label: "Assessment Title", value: formTitle),
            InfoText(label: "Created At", value: createdAt.toString()),
            InfoText(label: "Duration (seconds)", value: durationSeconds?.toString() ?? 'N/A'),
          ],
        ),
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
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
