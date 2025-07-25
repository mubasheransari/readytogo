import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/Donate/add_new_card.dart';
import 'package:readytogo/Features/home_screen.dart';
import 'package:readytogo/Features/login/emergency_call_screen.dart';
import 'package:readytogo/Features/login/invite_friend.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import '../../Constants/constants.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

var storage = GetStorage();

var role = storage.read("role");

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          decoration: boxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                Image.asset('assets/logo.png', height: 120, width: 115),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const CustomTextWidget(
                  text: "Welcome Back",
                  color: Colors.black87,
                  textSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    // Side effects like navigation or toast can go here
                    // Example: if (state.status == LoginStatus.error) show error dialog
                  },
                  builder: (context, state) {
                    final storage = GetStorage();
                    final String? role = storage.read("role");
                    print("ROLE ::::: $role");

                    if (role == "Individual") {
                      if (state.profile != null) {
                        final profile = state.profile!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500,
                        );
                      } else if (state.status == LoginStatus.profileLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                    } else if (role == "Professional") {
                      print("PROFESSIONAL STATUS ${state.professionalStatus}");
                      print(
                          "MODEL PROFESSIONAL LENGTH ${state.professionalProfileModel}");
                      if (state.professionalStatus ==
                          ProfessionalStatus.success) {
                        final profile = state.professionalProfileModel!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500, //10@Testing
                        );
                      } else if (state.status ==
                          LoginStatus.professionalProfileLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                    } else if (role == "Organization") {
                      if (state.organizationalStatus ==
                              OrganizationalStatus.success &&
                          state.organizationProfileModel != null) {
                        final profile = state.organizationProfileModel!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500,
                        );
                      } else if (state.organizationalStatus ==
                          OrganizationalStatus.loading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                    }

                    return Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    );
                  },
                ),

                /// Profile Loader and Name//10@Testing
                /*  BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    // final role = state.role;
                    final storage = GetStorage();
                    final String? role = storage.read("role");
                    print("ROLE ::::: $role");
                    print("ROLE ::::: $role");
                    print("ROLE ::::: $role");
                    print("ROLE ::::: $role");

                    if (role == "Individual") {
                        // if (state.status == LoginStatus.profileLoaded &&
                        //   state.profile != null)
                      if (
                          state.profile != null) {
                        final profile = state.profile!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500,
                        );
                      } else if (state.status == LoginStatus.profileLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                    } else if (role == "Professional") {
                      if (state.professionalStatus == ProfessionalStatus.success &&
                          state.professionalProfileModel != null) {
                        final profile = state.professionalProfileModel!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500,
                        );
                      } else if (state.status ==
                          LoginStatus.professionalProfileLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                      
                    }

                    else if (role == "Organization") {
                      if (state.organizationalStatus ==
                              OrganizationalStatus.success &&
                          state.organizationProfileModel != null) {
                        final profile = state.organizationProfileModel!;
                        return CustomTextWidget(
                          text: '${profile.firstname} ${profile.lastname}',
                          color: Constants().themeColor,
                          textSize: 35,
                          fontWeight: FontWeight.w500,
                        );
                      } else if (state.organizationalStatus ==
                              OrganizationalStatus.loading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      }
                      
                    }
                    

                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    );
                  },
                ),*/

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                /// Home Button
                _buildButton(
                  context: context,
                  label: 'Home',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                /// Emergency Button
                _buildButton(
                  context: context,
                  label: 'Emergency',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EmergencyCallScreen()));
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                /// Invite Friend Button
                _buildButton(
                  context: context,
                  label: 'Invite a friend',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InviteFriendScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants().themeColor,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Satoshi',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.north_east, size: 20, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}


/*class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
            decoration: boxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Image.asset('assets/logo.png', height: 120, width: 115),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextWidget(
                      text: "Welcome Back",
                      color: Colors.black87,
                      textSize: 30,
                      fontWeight: FontWeight.w500),
          role == "Individual"?        BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state.status == LoginStatus.profileLoaded &&
                          state.profile != null) {
                        final profile = state.profile!;
                        return CustomTextWidget(
                            text: '${profile.firstname} ${profile.lastname}',
                            color: Constants().themeColor,
                            textSize: 35,
                            fontWeight: FontWeight.w500);
                      } else if (state.status == LoginStatus.profileLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      } else {
                        return const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        );
                      }
                    },
                  ):BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state.status == LoginStatus.professionalProfileLoaded &&
                          state.professionalProfileModel!= null) {
                        final profile = state.professionalProfileModel!;
                        return CustomTextWidget(
                            text: '${profile.firstname} ${profile.lastname}',
                            color: Constants().themeColor,
                            textSize: 35,
                            fontWeight: FontWeight.w500);
                      } else if (state.status == LoginStatus.professionalProfileLoaded) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      } else {
                        return const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        );
                      }
                    },
                  ),

                  // CustomTextWidget(
                  //     text: "Peter Patrick",
                  //     color: Constants().themeColor,
                  //     textSize: 35,
                  //     fontWeight: FontWeight.w500),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Home',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /* SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSuccessScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'New Search',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east, size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  */
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85, //376,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmergencyCallScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Emergency',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    //  width: 376,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteFriendScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Invite a friend',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}*/
