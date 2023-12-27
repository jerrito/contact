import 'package:go_router/go_router.dart';
import 'package:house_rental/connection_page.dart';
import 'package:house_rental/src/authentication/presentation/pages/otp_page.dart';
import 'package:house_rental/src/authentication/presentation/pages/phone_number_page.dart';
import 'package:house_rental/src/authentication/presentation/pages/signin_page.dart';
import 'package:house_rental/src/authentication/presentation/pages/signup_page.dart';
import 'package:house_rental/src/home/presentation/pages/home_page.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: "/", 
  routes: [
    GoRoute(
        path: "/",
        name: "connectionPage",
        builder: (context, state) => const ConnectionPage(),
        routes: [
          GoRoute(
            path: "signup",
            name: "signup",
            builder: (context, state) => SignupPage(
              phoneNumber: state.uri.queryParameters["phone_number"].toString(),
              uid: state.uri.queryParameters["uid"].toString(),
            ),
          ),
          GoRoute(
            path: "signin",
            name: "signin",
            builder: (context, state) => SigninPage(
              phoneNumber: state.uri.queryParameters["phone_number"].toString(),
              uid: state.uri.queryParameters["uid"].toString(),
              id: state.uri.queryParameters["id"].toString(),
            ),
          ),
          GoRoute(
            path: "otp_page",
            name: "otp",
            builder: (context, state) => OTPPage(
              otpRequest: OTPRequest(
                isLogin:
                    bool.parse(state.uri.queryParameters["isLogin"].toString()),
                verifyId: state.uri.queryParameters["verify_id"].toString(),
                phoneNumber:
                    state.uri.queryParameters["phone_number"].toString(),
                forceResendingToken: int.parse(state
                    .uri.queryParameters["force_resending_token"]
                    .toString()),
              ),
            ),
          ),
          GoRoute(
            path: "phone_number",
            name: "phoneNumber",
            builder: (context, state) => PhoneNumberPage(
                isLogin: bool.parse(
                    state.uri.queryParameters["isLogin"].toString())),
          ),
          GoRoute(
            path: "home",
            name: "homePage",
            builder: (context, state) => const HomePage(),
          )
        ])
  ]);
}
