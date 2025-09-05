import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:readytogo/Features/admin/dashboard/bloc/user_assessments_event.dart';
import 'package:readytogo/Features/admin/dashboard/bloc/user_assessments_state.dart';
import 'package:readytogo/Repositories/assessment_repository.dart';

class UserAssessmentsBloc extends Bloc<UserAssessmentsEvent, UserAssessmentsState> {
  final AssessmentRepository repository;

  UserAssessmentsBloc(this.repository) : super(UserAssessmentsInitial()) {
    on<FetchUserAssessments>(_onFetchUserAssessments);
  }

  Future<void> _onFetchUserAssessments(
    FetchUserAssessments event,
    Emitter<UserAssessmentsState> emit,
  ) async {
    emit(UserAssessmentsLoading());
    try {
      final assessments = await repository.fetchAssessments();
      emit(UserAssessmentsLoaded(assessments));
    } catch (e, stack) {
      debugPrint('[UserAssessmentsBloc] Exception: $e');
      debugPrint('[UserAssessmentsBloc] StackTrace: $stack');
      emit(UserAssessmentsError(e.toString()));
    }
  }
}
