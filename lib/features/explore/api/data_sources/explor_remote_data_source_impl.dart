import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/explore/api/explor_api_client/explor_api_client.dart';
import 'package:online_exam_app_v/features/explore/data/data_sources/explor_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/explore/data/mapper/subject_mapper.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

@Injectable(as: ExplorRemoteDataSourceContract)
class ExplorRemoteDataSourceImpl implements ExplorRemoteDataSourceContract {
  ExplorApiClient apiClient;

  ExplorRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Subject>> getSubjects() async {
    final response = await apiClient.getSubjectList();
    return SubjectMapper.toSubjectEntity(response);
  }
}
