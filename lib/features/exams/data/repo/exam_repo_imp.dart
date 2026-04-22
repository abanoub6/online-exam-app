import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/api/data_source/exam_remote_data_source_imp.dart';
import 'package:online_exam_app_v/features/exams/data/data_source/exam_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/domain/repo/exam_repo_contract.dart';

class ExamRepoImp implements ExamRepoContract {
  ExamRepoImp(this.examRemoteDataSourceContract);
  ExamRemoteDataSourceContract examRemoteDataSourceContract;
  
  get ExamDtos => null;
  @override
  Future<BaseResponse<List<ExamEntity>>> getAllExams() async {
    return examRemoteDataSourceContract.getAllExams().then(ExamDtos);
    return ExamDtos.map((dto) => dto.toDomain()).toList();
  }
}
