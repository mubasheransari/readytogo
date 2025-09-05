import 'package:equatable/equatable.dart';

abstract class UserAssessmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserAssessments extends UserAssessmentsEvent {
  final int page;
  FetchUserAssessments({this.page = 1});

  @override
  List<Object?> get props => [page];
}
