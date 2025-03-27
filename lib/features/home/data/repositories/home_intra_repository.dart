import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as oauth2;

import 'package:mi_fortitu/features/home/data/models/models.dart';

import '../../../../core/utils/secure_storage_helper.dart';
import '../../../home/domain/failures.dart';
import '../../domain/entities/intra_event.dart';
import '../../domain/entities/intra_profile.dart';

class HomeIntraRepository {

  Future<Either<Failure,IntraProfile>> getIntraProfile(String loginName) async {
    try {
      final bearerToken = await SecureStorageHelper.getIntraAccessToken();
      if (bearerToken == null) {
        return Left(AuthFailure('No token found'));
      }

      final response = await oauth2.get(
        Uri.parse('https://api.intra.42.fr/v2/users/$loginName'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );
      final Map<String, dynamic> data = await jsonDecode(response.body);

      return Right(IntraProfileModel.fromJson(data).toEntity());
    } catch (e) {
      throw Exception('Profile data failure: Data not found.');
    }
  }

  Future<Either<Failure,List<IntraEvent>>> getIntraUserEvents(String loginName) async {
    try {
      final bearerToken = await SecureStorageHelper.getIntraAccessToken();
      if (bearerToken == null) {
        return Left(AuthFailure('No token found'));
      }

      final response = await oauth2.get(
        Uri.parse('https://api.intra.42.fr/v2/users/$loginName/events'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        }
      );
      final List<dynamic> jsonData = await jsonDecode(response.body);
      final List<IntraEventModel> events = jsonData
          .map((e) => IntraEventModel.fromJson(e))
          .toList();
      return Right(events.map((model) => model.toEntity()).toList());
    } catch (e) {
      throw ('Events data (user) failure: Data not found.');
    }
  }

  Future<Either<Failure,List<IntraEvent>>> getIntraCampusEvents() async {
    try {
      final bearerToken = await SecureStorageHelper.getIntraAccessToken();
      if (bearerToken == null) {
        return Left(AuthFailure('No token found'));
      }

      final response = await oauth2.get(
        Uri.parse('https://api.intra.42.fr/v2/campus/37/events'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        }
      );
      final List<dynamic> jsonData = await jsonDecode(response.body);
      final List<IntraEventModel> events = jsonData
          .map((e) => IntraEventModel.fromJson(e))
          .toList();
      return Right(events.map((model) => model.toEntity()).toList());
    } catch (e) {
      throw ('Events data (cursus) failure: Data not found.');
    }
  }
}
