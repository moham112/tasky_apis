import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';
import 'package:tasky_apis/data/models/task_creation_request.dart';

class TaskCreationWebServices {
  // Future<dynamic> uploadTaskImage(File imageFile) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       'file': await MultipartFile.fromFile(imageFile.path),
  //     });

  //     final response = await DioHelper.postData(
  //       endPoint: endPoints['upload-image']!,
  //       body: formData,
  //       headers: {'Content-Type': 'multipart/form-data'},
  //     );
  //     if (response.statusCode == 200) {
  //       return response.data['image'];
  //     } else {
  //       throw Exception('Failed to upload image');
  //     }
  //   } catch (e) {
  //     throw Exception('Image upload failed');
  //   }
  // }

  Future<dynamic> createTask(TaskCreationRequest taskCreationRequest) async {
    // String path = await uploadTaskImage(imageFile);
    // taskCreationRequest.image = path;

    final response = await DioHelper.postData(
        endPoint: endPoints['create-task']!,
        body: taskCreationRequest.toJson());
    return response.data;
  }
}
