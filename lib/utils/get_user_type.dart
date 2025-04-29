import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/auth/auth_cubit.dart';

class GetUserType {
  static Future<bool> isMerchantUser(context) async {
    final user = BlocProvider.of<AuthCubit>(context, listen: false)
        .repository
        .getLoggedInUser();
    return user != null && user.role == "merchant";
  }
}
