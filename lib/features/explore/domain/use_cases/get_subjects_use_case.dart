import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';
import 'package:online_exam_app_v/features/explore/domain/repo/explor_repo_contract.dart';

@injectable
class GetSubjectsUseCase {
  final ExplorRepoContract _repository;

  GetSubjectsUseCase(this._repository);

  Future<BaseResponse<List<Subject>>> call() => _repository.getSubjects();
}
