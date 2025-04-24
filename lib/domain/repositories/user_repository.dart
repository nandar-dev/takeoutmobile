
import 'package:takeout/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
}
