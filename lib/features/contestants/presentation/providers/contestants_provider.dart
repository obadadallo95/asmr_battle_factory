import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/contestant_repository_impl.dart';
import '../../../generator/domain/entities/contestant.dart';
import '../../../../config/di/injection.dart';

final contestantsProvider = FutureProvider<List<Contestant>>((ref) async {
  final repository = getIt<ContestantRepository>();
  return repository.getAll();
});
