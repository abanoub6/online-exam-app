import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/domain/use_cases/get_all_exams_use_case.dart';
import 'package:online_exam_app_v/features/exams/domain/use_cases/get_exams_by_subject_use_case.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_events.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_state.dart';

@injectable
class ExamsViewModel extends Cubit<ExamsState> {
  final GetAllExamsUseCase _getAllExamsUseCase;
  final GetExamsBySubjectUseCase _getExamsBySubjectUseCase;

  ExamsViewModel(this._getAllExamsUseCase, this._getExamsBySubjectUseCase)
    : super(const ExamsInitial());

  Future<void> doEvent(ExamsEvents event) async {
    switch (event) {
      case GetAllExamsEvent():
        await _getAllExams();
      case GetExamsBySubjectEvent():
        await _getExamsBySubject(event.subjectId);
    }
  }

  Future<void> _getAllExams() async {
    emit(const ExamsLoading());
    final result = await _getAllExamsUseCase();
    switch (result) {
      case SuccessBaseResponse<List<ExamEntity>>():
        emit(ExamsSuccess(result.data));
      case ErrorBaseResponse<List<ExamEntity>>():
        emit(ExamsFailure(result.errorMessage));
    }
  }

  Future<void> _getExamsBySubject(String subjectId) async {
    emit(const ExamsLoading());
    final result = await _getExamsBySubjectUseCase(subjectId);
    switch (result) {
      case SuccessBaseResponse<List<ExamEntity>>():
        emit(ExamsSuccess(result.data));
      case ErrorBaseResponse<List<ExamEntity>>():
        emit(ExamsFailure(result.errorMessage));
    }
  }
}
