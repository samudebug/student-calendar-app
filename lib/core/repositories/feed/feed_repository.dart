import 'package:student_calendar_app/core/repositories/feed/feed_section.dart';

abstract class FeedRepository {
  Future<(int, List<FeedSection>)> fetchFeed({int? page});
}