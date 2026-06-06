import 'package:otakulog/data/models/daily_activity.dart';
import 'package:otakulog/domain/entities/activity.dart';

class ActivityMapper {
  static DailyActivity toModel(Activity activity) {
    return DailyActivity()
      ..date = activity.date
      ..minutesWatched = activity.minutesWatched
      ..minutesRead = activity.minutesRead;
  }

  static Activity toEntity(DailyActivity model) {
    return Activity(
      id: model.id,
      date: model.date,
      minutesWatched: model.minutesWatched,
      minutesRead: model.minutesRead,
    );
  }
}