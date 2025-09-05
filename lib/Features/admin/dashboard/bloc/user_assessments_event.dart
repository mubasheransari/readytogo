import 'package:equatable/equatable.dart';

abstract class UserAssessmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserAssessments extends UserAssessmentsEvent {}
