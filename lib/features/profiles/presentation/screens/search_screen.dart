import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search_bloc/search_bloc.dart';
import '../widgets/app_bar_search.dart';

import '../blocs/user_bloc/user_bloc.dart';
import '../widgets/cursus_profile.dart';

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
        onSearch: () {
          final searchText = _searchController.text;
          if (searchText.isNotEmpty) {
            context.read<SearchBloc>().add(GetSearchProfileEvent(searchText));
          }
        },
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return _SearchView();
          } else if (state is SearchLoading) {
            return _LoadingView();
          } else if (state is SearchError) {
            return _ErrorView(message: state.message);
          } else if (state is SearchSuccess) {
            final intraProfile = state.profile;
            return CursusProfile(profile: intraProfile);
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: 300, child: Image.asset('assets/images/gif/search_student.png')),
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(tr('search.no_results'))));
  }
}
