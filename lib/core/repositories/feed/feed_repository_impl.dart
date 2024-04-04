import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/core/environment.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_repository.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_section.dart';

class FeedRepositoryImpl extends GetConnect implements FeedRepository {
  final authRepo = Get.find<AuthRepository>();
  @override
  void onInit() {
    httpClient.baseUrl = '${Environment.apiUrl}';
    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await authRepo.getToken();
      request.headers['Authorization'] = token;
      return request;
    });
    httpClient.maxAuthRetries = 3;
  }

  @override
  Future<(int, List<FeedSection>)> fetchFeed({int? page = 1}) async {

    final response = await get('/users/me/tasks', query: {'page': page.toString()});
    
    final List<Task> results =
        (response.body['results'] as List<dynamic>).map((e) => Task.fromJson(e)).toList();
    final mapResult = Map<String, List<Task>>();
    results.forEach((Task e) {
      String key = DateFormat('EEEE, MMM d').format(e.deliverDate);
      if (DateUtils.isSameDay(e.deliverDate, DateTime.now())) {
        key = 'Today';
      }
      if (!mapResult.keys.contains(key)) {
        mapResult[key] = [];
      }
      mapResult[key]!.add(e);
    });
    final sections = <FeedSection>[];
    mapResult.forEach((key, value) {
      sections.add(FeedSection(date: key, tasks: value));
    });
    final totalPages = ((response.body['total'] as int) / 30).ceil();
    return (totalPages,sections);
  }
}
