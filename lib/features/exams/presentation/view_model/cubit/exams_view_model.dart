import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/domain/use_cases/get_all_exams_use_case.dart';
import 'package:online_exam_app_v/features/exams/presentation/states/exams_state.dart';

class ExamsViewModel extends Cubit<ExamsState>{
  ExamsViewModel(this._getAllExamsUseCase):super(ExamsState());

  final GetAllExamsUseCase _getAllExamsUseCase;

  Future<void> getAllExams() async {
   BaseResponse<List<ExamEntity> exams = await getAllExamsUseCase();
  }
}
