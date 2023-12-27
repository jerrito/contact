import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  final String? uid;
  final bool? isLogin;
  final String? phoneNumber;
  const HomePage({
    super.key,
    this.uid,
    this.isLogin,
    this.phoneNumber,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authBloc = locator<AuthenticationBloc>();

  User? user;
  @override
  void initState() {
    super.initState();

    authBloc.add(const GetCacheDataEvent());

    Future.delayed(const Duration(seconds: 2), () {
      debugPrint(user?.id);
      debugPrint(user?.uid);
      if (user?.id == null || user?.uid == null) {
        Map<String, dynamic> params = {
          "phone_number": user?.phoneNumber,
          "uid": widget.uid,
        };
        authBloc.add(
          AddIdEvent(
            params: params,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(user?.id);

    return Scaffold(
        drawer: HomeDrawer(
          firstName: " ${user?.firstName}",
          lastName: "${user?.lastName}",
          phoneNumber: user?.phoneNumber,
          profileUrl: user?.profileUrl,
          id: user?.id,
          uid: user?.uid,
          email: user?.email,
        ),
        appBar: AppBar(title: const Text("Home Page")),
        body: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            if (state is GetCacheDataLoaded) {
              user = state.user;
              debugPrint(user?.toMap().toString());
              setState(() {});
            }
          },
          builder: (context, state) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.firstName ?? "",
                  ),
                  Text(
                    user?.lastName ?? "",
                  ),
                  Text(
                    user?.email ?? "",
                  ),
                ]);
          },
        ));
  }
}
