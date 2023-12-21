import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            if (state is GetCacheDataLoaded) {
              user = state.user;
              setState(() {});
            }
          },
          builder: (context, state) {
            return Column(children: [
              Text(user?.firstName??""),
              Text(user?.lastName??""),
              Text(user?.email??""),
              Text(user?.firstName??""),
              ]);
          },
        ));
  }
}
