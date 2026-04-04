import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

abstract class ExplorRepoContract {
  Future<BaseResponse<List<Subject>>> getSubjects();
}
