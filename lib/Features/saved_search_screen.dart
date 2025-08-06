import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'login/bloc/login_event.dart';

class SavedSearchScreen extends StatefulWidget {
  const SavedSearchScreen({super.key});

  @override
  State<SavedSearchScreen> createState() => _SavedSearchScreenState();
}

class _SavedSearchScreenState extends State<SavedSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: "Saved Search",
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // Add any snackbars or side effects here
        },
        builder: (context, state) {
          final savedSearches = state.savedSearchModel;

          if (savedSearches == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (savedSearches.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: const Center(child: Text("No Saved Searches")),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: List.generate(savedSearches.length, (index) {
                final model = savedSearches[index];
                return DoctorCard(
                  onFavoriteTap: () {
                    // Trigger a BLoC event to remove this saved search
                    // context
                    //     .read<LoginBloc>()
                    //     .add(RemoveSavedSearch(index.toString()));
                    // LoginRepository().removeSavedSearch(
                    //     savedSearches[index].userId.toString());

                    final userId = savedSearches[index].locations![index].id;
                    print("USER ID $userId");
                    print("USER ID $userId");
                    print("USER ID $userId");
                    context.read<LoginBloc>().add(RemoveSavedSearch(
                        savedSearches[index].userId.toString()));
                    LoginRepository().removeSavedSearch(userId.toString());
                  },
                  profileImage: model.profileImageUrl != null
                      ? "http://173.249.27.4:343/${model.profileImageUrl}"
                      : "https://i.pravatar.cc/100?img=60",
                  // 'https://i.pravatar.cc/100?img=60',
                  name: "${model.firstName} ${model.lastName}",
                  phone: model.phoneNumber ?? "",
                  email: model.email ?? "",
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

// class SavedSearchScreen extends StatefulWidget {
//   const SavedSearchScreen({super.key});

//   @override
//   State<SavedSearchScreen> createState() => _SavedSearchScreenState();
// }

// class _SavedSearchScreenState extends State<SavedSearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffoldWidget(
//       appbartitle: "Saved Search",
//       //  showNotificationIcon: false,
//       body: SingleChildScrollView(
//         child: Container(
//          /// color: Colors.white,
//           child: Column(
//             children: [
//            context.read<LoginBloc>().state.savedSearchModel!.isNotEmpty?    BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: state.savedSearchModel!.length,
//                     itemBuilder: (context, index) {
//                       return DoctorCard(
//                         onFavoriteTap: () {
//                           setState(() {
//                             state.savedSearchModel!.removeAt(index);
//                           });
//                         },
//                         profileImage: 'https://i.pravatar.cc/100?img=60',
//                         name:
//                             "${state.savedSearchModel![index].firstName} ${state.savedSearchModel![index].lastName}",
//                         phone: state.savedSearchModel![index].phoneNumber
//                             .toString(),
//                         email: state.savedSearchModel![index].email.toString(),
//                         // state.savedSearchModel![index].profileImageUrl!,
//                       );
//                     });
//               }):

//                   Padding(
//                     padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height *0.35),
//                     child: Center(child: Text("No Saved Searches"),),
//                   ),

//               //SizedBox(height: 100,)
//             ],
//           ),
//         ),
//       ),
//     ); //10@Testing
//   }
// }

class DoctorCard extends StatelessWidget {
  String profileImage, name, phone, email;
  final VoidCallback onFavoriteTap;
  DoctorCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.phone,
    required this.email,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Image, Name & Heart Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  profileImage,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),

              // Name and Specialty
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      phone, //'+0594 56249 5894',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),

              // Heart Icon
              InkWell(
                  onTap: onFavoriteTap,
                  child: Icon(Icons.favorite, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 14),

          // Divider Row
          const Divider(height: 1, color: Colors.black12),
          const SizedBox(height: 14),

          // Email and Phone Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone:',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(email),
                    SizedBox(height: 10),
                    Text('$phone'),
                  ],
                ),
              ),

              // Call Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFD7E3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.phone, color: Colors.blueAccent),
              )
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.black12),
          const SizedBox(height: 12),

          // Bottom Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoText(title: 'Service', value: 'Pediatrician'),
              _InfoText(title: 'Location', value: 'Distance 3.2 km'),
              _InfoText(title: 'Member', value: 'Since July 15th'),
            ],
          ),
          //  SizedBox(height: 100,)
        ],
      ),
    );
  }
}

// Subcomponent for bottom row info
class _InfoText extends StatelessWidget {
  final String title;
  final String value;
  const _InfoText({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final bool isLink = value.contains("Distance") || value.contains("Since");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: isLink ? Colors.blue : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
