import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/phone_number_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final authBloc = locator<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    authBloc.add(const GetCacheDataEvent());
    return Scaffold(
        body: BlocConsumer(
      bloc: authBloc,
      listener: (context, state) {
        if (state is GetCacheDataLoaded) {
          if (state.user.phoneNumber != null) {
            debugPrint("hei");
            context.goNamed("homePage");
          }
          if (state.user.uid == null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PhoneNumberPage(
              isLogin:true,
            );
          }));
           // context.goNamed("signin");
          } else {
            context.goNamed("signup");
          }
        }
        if (state is GetCacheDataError) {
          debugPrint(state.errorMessage);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PhoneNumberPage(
              isLogin:false,
            );
          }));

         // context.goNamed("phoneNumber", );
        }
      },
      builder: (context, state) {
        return const SizedBox();
      },
    ));
  }
}
