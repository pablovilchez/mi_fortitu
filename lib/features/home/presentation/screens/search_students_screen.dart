import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_search_profile_bloc/intra_search_profile_bloc.dart';

import '../widgets/top_search_bar.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            TopSearchBar(
              controller: _searchController,
              onSearch: () {
                context.read<IntraSearchProfileBloc>().add(
                  GetIntraSearchProfileEvent(_searchController.text),
                );
              },
              onBack: () {
                GoRouter.of(context).pop();
              },
            ),
            Expanded(
              child: BlocBuilder<IntraSearchProfileBloc, IntraSearchProfileState>(
                builder: (context, state) {
                  print('state: $state');
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
            ),
          ],
        ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Search Students'),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
