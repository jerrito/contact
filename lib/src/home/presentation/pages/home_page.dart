import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/home_drawer.dart';
import 'package:house_rental/src/home/presentation/widgets/house_container.dart';
import 'package:house_rental/src/home/presentation/widgets/house_row_details.dart';
import 'package:house_rental/src/home/presentation/widgets/list_view_buttons.dart';
import 'package:house_rental/src/home/presentation/widgets/search_textfield.dart';

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
  final homeBloc = locator<HomeBloc>();
  final searchController = TextEditingController();

  User? user;
  @override
  void initState() {
    super.initState();

    authBloc.add(const GetCacheDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(user?.id);

    debugPrint(user?.uid);
    return Scaffold(
        drawer: HomeDrawer(
          user: user ??
              User(
                  firstName: "",
                  lastName: "",
                  email: "",
                  phoneNumber: "",
                  id: "",
                  uid: "",
                  password: "",
                  profileUrl: ""),
        ),
        // appBar: AppBar(title: const Text("Home Page")),
        body: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            if (state is GetCacheDataLoaded) {
              user = state.user;
              debugPrint(user?.toMap().toString());
              setState(() {});
              Map<String,dynamic> params = {};
              homeBloc.add(GetAllHousesEvent(params: params));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                  //  mainAxisSize : MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Space().height(context, 0.04),
                    // SingleChildScrollView(
                    //   child: ExpansionTile(
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //     onExpansionChanged: (value){

                    //     },

                    //    expandedCrossAxisAlignment: CrossAxisAlignment.end,
                    //    expandedAlignment: Alignment.bottomCenter,
                    //     title:  const Text("Ja"),
                    //     children: [
                    //       const Text("La"),
                    //       const Text("UK"),
                    //       const Text("GE"),
                    //     ],
                    //   ),
                    // ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [SvgPicture.asset(notificationSVG)]),
                    Space().height(context, 0.02),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SearchTextField(
                            label: "Search address or near you",
                            onChanged: null,
                            controller: searchController,
                            onTap: null,
                          ),
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                              Future.delayed(const Duration(seconds: 1), () {
                                // debugPrint(user?.id);

                                //if(widget)
                                if (user?.id == null || user?.uid == null) {
                                  Map<String, dynamic> params = {
                                    "phone_number": user?.phoneNumber,
                                    "uid": widget.uid,
                                  };
                                  debugPrint(user?.uid);
                                  debugPrint(user?.phoneNumber);
                                  authBloc.add(
                                    AddIdEvent(
                                      params: params,
                                    ),
                                  );
                                } else {}
                              });
                            },
                            child: SvgPicture.asset(
                              menuSVG,
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Space().height(context, 0.02),

                    const HouseCategories(),

                    Space().height(context, 0.05),

                    Center(child: HouseContainer(
                      onTap: () {
                        context.goNamed("houseDetail");
                      },
                    )),

                    Space().height(context, 0.032),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Best for you",
                                style: appTheme.textTheme.displayLarge!
                                    .copyWith(fontWeight: FontWeight.w500)),
                            Text(
                              "See more",
                              style: appTheme.textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: searchTextColor2,
                                  fontSize: 12),
                            )
                          ]),
                    ),

                    //Space().height(context, 0.02),

                    BlocConsumer(
                        bloc: homeBloc,
                        listener: (context, state) {
                          if (state is GetAllHousesError) {
                            print(state.errorMessage);
                          }
                        },
                        builder: (context, state) {
                          if (state is GetALLHousesLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is GetAllHousesLoaded) {
                            print(state.houseDetail.length);
                          }
                          return ListView.builder(
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return const HouseRowDetails();
                              });
                        }),
                    // const HouseRowDetails(),
                    // const HouseRowDetails(),
                    // const HouseRowDetails(),
                  ]),
            );
          },
        ));
  }
}

class Jerrito extends StatefulWidget {
  const Jerrito({super.key});
  @override
  State<Jerrito> createState() => _Jerrito();
}

class _Jerrito extends State<Jerrito> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class Kerrito extends StatefulWidget {
  const Kerrito({super.key});

  @override
  State<Kerrito> createState() => _KerritoState();
}

class _KerritoState extends State<Kerrito> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(

        // child: List.filled(elements),
        );
  }
}

class Test {
  int i = 1;
  int sum() {
    return i++;
  }
}
