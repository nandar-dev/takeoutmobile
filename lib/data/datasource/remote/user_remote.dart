// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:takeout/api/api_service.dart';
// import 'package:takeout/data/models/user_model.dart';
// import 'package:takeout/utils/token_service.dart';

// class UserRemoteDataSource {
//   final Dio dio;

//   UserRemoteDataSource(this.dio);

//   Future<UserModel> login(String email, String password) async {
//     final response = await APIService.request(
//       '/user/login',
//       DioMethod.post,
//       data: {'email': email, 'password': password},
//     );
//     final data = response.data;
//     final token = data['data']['token'];
//     await TokenStorage.saveToken(token);
//     return UserModel.fromJson(data);
//   }

//   Future<UserModel> register(String name, String email, String password) async {
//     final response = await APIService.request(
//       '/user/register',
//       DioMethod.post,
//       data: {
//         'name': name,
//         'email': email,
//         'password': password,
//         'confirm_password': password,
//       },
//     );
//     final data = response.data;
//     return UserModel.fromJson(data);
//   }

//   Future logout() async {
//     final response = await APIService.request('/user/logout', DioMethod.post);
//     final data = response.data;
//     return data;
//   }

//   Future<UserModel> updateProfile(
//     String name,
//     String email,
//     String phone,
//     String address,
//   ) async {
//     final response = await APIService.request(
//       '/user/profile/update',
//       DioMethod.post,
//       data: {'name': name, 'email': email, 'phone': phone, 'address': address},
//     );
//     final data = response.data;
//     return UserModel.fromJson(data);
//   }

//   Future<UserModel> updateProfileImage(PlatformFile imageFile) async {
//     final formData = FormData.fromMap({
//       'image': await MultipartFile.fromFile(imageFile.path!),
//     });

//     final response = await APIService.request(
//       '/user/profile/uploadimage',
//       DioMethod.post,
//       data: formData,
//     );
//     final data = response.data;
//     return UserModel.fromJson(data);
//   }
// }


import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/utils/token_service.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<UserModel> login(String email, String password) async {
    final response = await APIService.request(
      '/user/login',
      DioMethod.post,
      data: {'email': email, 'password': password},
    );
    final data = response.data['data'];
    final token = data['token'];
    await TokenStorage.saveToken(token);
    return UserModel.fromJson(data['user']);
  }

  Future<UserModel> register(String name, String email, String password) async {
    final response = await APIService.request(
      '/user/register',
      DioMethod.post,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': password,
      },
    );
    final data = response.data['data'];
    return UserModel.fromJson(data['user']);
  }

  Future logout() async {
    final response = await APIService.request('/user/logout', DioMethod.post);
    return response.data;
  }

  Future<UserModel> updateProfile(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    final response = await APIService.request(
      '/user/profile/update',
      DioMethod.post,
      data: {'name': name, 'email': email, 'phone': phone, 'address': address},
    );
    final data = response.data['data'];
    return UserModel.fromJson(data);
  }

  Future<UserModel> updateProfileImage(PlatformFile imageFile) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path!),
    });

    final response = await APIService.request(
      '/user/profile/uploadimage',
      DioMethod.post,
      data: formData,
    );
    final data = response.data['data'];
    return UserModel.fromJson(data);
  }
}
