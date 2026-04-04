import 'package:online_exam_app_v/features/explore/data/models/response/subject_response_model.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

class SubjectMapper {
  static List<Subject> toSubjectEntity(SubjectResponseModel subjectResponse) {
    if (subjectResponse.subjects == null) return [];
    return subjectResponse.subjects!
        .map((e) => Subject(id: e!.id!, name: e.name!, icon: e.icon!))
        .toList();
  }
}
