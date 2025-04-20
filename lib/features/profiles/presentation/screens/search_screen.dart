import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mi_fortitu/features/profiles/domain/entities/user_entity.dart';

import '../../domain/usecases/get_profile_usecase.dart';
import '../widgets/app_bar_search.dart';

import '../widgets/cursus_profile.dart';

enum SearchStatus { initial, loading, success, error }

class SearchStudentsScreen extends StatefulWidget {
  final String? loginName;

  const SearchStudentsScreen({super.key, this.loginName});

  @override
  State<SearchStudentsScreen> createState() => _SearchStudentsScreenState();
}

class _SearchStudentsScreenState extends State<SearchStudentsScreen> {
  final _searchController = TextEditingController();
  final GetProfileUsecase getProfileUsecase = GetIt.I();

  SearchStatus _status = SearchStatus.initial;
  UserEntity? _profile;
  String _errorMessage = '';
  late bool _showSearchBar;

  Future<void> _searchStudent(String loginName) async {
    setState(() => _status = SearchStatus.loading);

    final result = await getProfileUsecase(loginName);
    result.fold(
          (failure) {
        setState(() {
          _status = SearchStatus.error;
          _errorMessage = failure.toString();
        });
      },
          (profile) {
        setState(() {
          _status = SearchStatus.success;
          _profile = profile;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _showSearchBar = widget.loginName == null;

    if (widget.loginName != null) {
      _searchStudent(widget.loginName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showSearchBar
          ? AppBarSearch(
            controller: _searchController,
            onSearch: () {
              final searchText = _searchController.text.trim();
              if (searchText.isNotEmpty) {
                _searchStudent(searchText);
              }
            },
          )
          : AppBar(),
      body: Builder(
        builder: (_) {
          switch (_status) {
            case SearchStatus.initial:
              return _SearchView();
            case SearchStatus.loading:
              return _LoadingView();
            case SearchStatus.error:
              return _ErrorView(message: _errorMessage);
            case SearchStatus.success:
              return _profile != null
                  ? CursusProfile(profile: _profile!)
                  : const SizedBox();
          }
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
