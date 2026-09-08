import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<UserRepository>(),
  MockSpec<TeamRepository>(),
  MockSpec<LineupRepository>(),
  MockSpec<LobbyRepository>(),
  MockSpec<RaceWeekendRepository>(),
  MockSpec<DriverRepository>(),
])
void main() {}