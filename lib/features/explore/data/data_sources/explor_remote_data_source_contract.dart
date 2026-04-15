import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

abstract interface class ExplorRemoteDataSourceContract {
  Future<List<Subject>> getSubjects();
}
