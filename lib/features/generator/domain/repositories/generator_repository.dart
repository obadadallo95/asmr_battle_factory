// Lines: 10/300
import 'package:dartz/dartz.dart';
import '../entities/battle_script.dart';
import '../../../../core/errors/failures.dart';

abstract class GeneratorRepository {
  Future<Either<Failure, BattleScript>> generateBattleScript(List<String> contestants);
  Future<Either<Failure, List<String>>> generateBattleIdeas();
}
