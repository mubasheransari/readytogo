import 'package:equatable/equatable.dart';
import 'package:readytogo/Model/assessment_model.dart';

abstract class UserAssessmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAssessmentsInitial extends UserAssessmentsState {}

class UserAssessmentsLoading extends UserAssessmentsState {}

class UserAssessmentsLoaded extends UserAssessmentsState {
  final List<AssessmentModel> assessments;
  UserAssessmentsLoaded(this.assessments);

  @override
  List<Object?> get props => [assessments];
}

class UserAssessmentsError extends UserAssessmentsState {
  final String message;
  UserAssessmentsError(this.message);

  @override
  List<Object?> get props => [message];
}
