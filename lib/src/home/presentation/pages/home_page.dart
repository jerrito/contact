import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
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
  final searchController = TextEditingController();

  User? user;
  @override
  void initState() {
    super.initState();

    authBloc.add(const GetCacheDataEvent());

    Future.delayed(const Duration(seconds: 2), () {
      debugPrint(user?.id);
      debugPrint(user?.uid);
      //if(widget)
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
       // appBar: AppBar(title: const Text("Home Page")),
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
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:Sizes().width(context,0.04,),),
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
                        children:[
                       
                          SvgPicture.asset(notificationSVG)
                        ]
                      ),
                      Space().height(context, 0.02),
                    
                      Row(
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
                            },
                            child: SvgPicture.asset(
                              menuSVG,
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                       const ListViewRowButtons(),
                      Space().height(context, 0.05),
                       Center(child: HouseContainer(
                        onTap: (){
                          context.goNamed("houseDetail");
                        },
                      )),

                       Space().height(context, 0.02),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text("Best for you"),
              
                          Text("See more")
                        ]
                      ),

                      Space().height(context, 0.02),

                      //TODO: use listview to build
                      const HouseRowDetails(),
                      const HouseRowDetails(),
                      const HouseRowDetails(),
                      const HouseRowDetails(),
                    ]),
              ),
            );
          },
        ));
  }
}
