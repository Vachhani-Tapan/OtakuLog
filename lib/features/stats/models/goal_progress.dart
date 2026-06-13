class GoalProgress {
  final String id;
  final String goalType;
  final int target;
  final int current;

  const GoalProgress({
    required this.id,
    required this.goalType,
    required this.target,
    required this.current,
  });

  double get percentage =>
      target == 0 ? 0 : current / target;
}