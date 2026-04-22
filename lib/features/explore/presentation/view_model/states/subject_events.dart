import 'package:equatable/equatable.dart';

sealed class SubjectEvents extends Equatable {
  const SubjectEvents();
}

class GetSubjectEvent extends SubjectEvents {
  const GetSubjectEvent();

  @override
  List<Object?> get props => [];
}

class SearchSubjectsEvent extends SubjectEvents {
  final String query;
  const SearchSubjectsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
