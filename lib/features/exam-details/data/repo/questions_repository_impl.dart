import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/data/data-sources/questions_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/question_dto.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';
import 'package:online_exam_app_v/features/exam-details/domain/repo/questions_repository_contract.dart';

@Injectable(as: QuestionsRepositoryContract)
class QuestionsRepositoryImpl implements QuestionsRepositoryContract {
  final QuestionsRemoteDataSourceContract remoteDataSource;

  QuestionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<List<QuestionEntity>>> getQuestionsOnExam(
    String examId,
  ) async {
    final response = await remoteDataSource.getQuestionsOnExam(examId);

    switch (response) {
      case SuccessBaseResponse<List<QuestionDto>>():
        final entities = response.data
            .map((model) => model.toEntity())
            .toList();

        return SuccessBaseResponse<List<QuestionEntity>>(data: entities);

      case ErrorBaseResponse<List<QuestionDto>>():
        return ErrorBaseResponse<List<QuestionEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
