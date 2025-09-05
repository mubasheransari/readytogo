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
  final int page;
  final int totalPages;
  UserAssessmentsLoaded(this.assessments, {this.page = 1, this.totalPages = 1});

  @override
  List<Object?> get props => [assessments, page, totalPages];
}

class UserAssessmentsError extends UserAssessmentsState {
  final String message;
  UserAssessmentsError(this.message);

  @override
  List<Object?> get props => [message];
}
