import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_search_profile_bloc/intra_search_profile_bloc.dart';

import '../widgets/app_bar_search.dart';

class SearchStudentsScreen extends StatefulWidget {
  const SearchStudentsScreen({super.key});

  @override
  State<SearchStudentsScreen> createState() => SearchStudentsScreenState();
}

class SearchStudentsScreenState extends State<SearchStudentsScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        controller: _searchController,
        onSearch: () {},
      ),
      body: BlocBuilder<
        IntraSearchProfileBloc,
        IntraSearchProfileState
      >(
        builder: (context, state) {
          if (state is IntraSearchProfileInitial) {
            return _SearchView();
          } else if (state is IntraSearchProfileLoading) {
            return _LoadingView();
          } else if (state is IntraSearchProfileError) {
            return _ErrorView(message: state.message);
          } else if (state is IntraSearchProfileSuccess) {
            return _ProfileView();
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        SizedBox(
          width: 300,
            child: Image.asset('assets/images/gif/search_student.png')),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('search.hint'))),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Students')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Students')),
      body: Center(child: Text(message)),
    );
  }
}
