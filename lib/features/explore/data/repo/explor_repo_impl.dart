import 'package:injectable/injectable.dart';

import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/explore/data/data_sources/explor_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';
import 'package:online_exam_app_v/features/explore/domain/repo/explor_repo_contract.dart';

@Injectable(as: ExplorRepoContract)
class ExplorRepoImpl implements ExplorRepoContract {
  final ExplorRemoteDataSourceContract _remoteDataSource;

  ExplorRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<Subject>>> getSubjects() async {
    try {
      final subjects = await _remoteDataSource.getSubjects();
      return SuccessBaseResponse(data: subjects);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }
}
