import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';
import 'package:online_exam_app_v/features/explore/domain/use_cases/get_subjects_use_case.dart';
import 'package:online_exam_app_v/features/explore/presentation/view_model/states/subject_states.dart';
import 'package:online_exam_app_v/features/explore/presentation/view_model/states/subject_events.dart';

@injectable
class ExplorViewModel extends Cubit<SubjectState> {
  ExplorViewModel(this.getSubjects) : super(SubjectInitial());
  final GetSubjectsUseCase getSubjects;

  List<Subject> _allSubjects = [];

  Future<void> doEvent(SubjectEvents event) async {
    switch (event) {
      case GetSubjectEvent():
        await _getSubject();
      case SearchSubjectsEvent():
        _searchSubjects(event.query);
    }
  }

  Future<void> _getSubject() async {
    emit(GetSubjectLoading());
    var response = await getSubjects();
    switch (response) {
      case SuccessBaseResponse<List<Subject>>():
        _allSubjects = response.data;
        emit(GetSubjectSuccess(_allSubjects));
      case ErrorBaseResponse():
        emit(GetSubjectError(response.errorMessage));
    }
  }

  void _searchSubjects(String query) {
    if (query.isEmpty) {
      emit(GetSubjectSuccess(_allSubjects));
      return;
    }
    final filtered = _allSubjects
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(GetSubjectSuccess(filtered));
  }
}
