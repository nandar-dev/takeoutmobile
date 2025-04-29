import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_cubit.dart';

class GetUserType {
  static Future<bool> isMerchantUser(context) async {
    final user =
        BlocProvider.of<UserCubit>(
          context,
          listen: false,
        )
        .repository
        .getLoggedInUser();
    return user != null && user.role == "merchant";
  }
}
