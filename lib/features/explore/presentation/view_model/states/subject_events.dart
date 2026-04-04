sealed class SubjectEvents {}

class GetSubjectEvent extends SubjectEvents {}

class SearchSubjectsEvent extends SubjectEvents {
  final String query;
  SearchSubjectsEvent(this.query);
}
