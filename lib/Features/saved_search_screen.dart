import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

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
    //  showNotificationIcon: false,
      body: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
            return Text(state.getSavedSearchesStatus.toString());
          })
        ],
      ),
    );//10@Testing
  }
}
