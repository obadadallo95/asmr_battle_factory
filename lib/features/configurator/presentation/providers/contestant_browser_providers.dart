import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../generator/domain/entities/contestant.dart';
import '../../../contestants/data/repositories/contestant_repository_impl.dart';
import '../../../../config/di/injection.dart';


// Load all contestants from JSON
final allContestantsProvider = FutureProvider<List<Contestant>>((ref) async {
  final repo = getIt<ContestantRepository>();
  return await repo.getAll();
});

// Search query state
final contestantSearchProvider = StateProvider<String>((ref) => '');

// Selected category filter
final selectedCategoryProvider = StateProvider<ContestantCategory?>((ref) => null);

// Filtered contestants based on search and category
final filteredContestantsProvider = Provider<AsyncValue<List<Contestant>>>((ref) {
  final allContestantsAsync = ref.watch(allContestantsProvider);
  final searchQuery = ref.watch(contestantSearchProvider).toLowerCase();
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return allContestantsAsync.whenData((contestants) {
    var filtered = contestants;

    // Filter by category
    if (selectedCategory != null && selectedCategory != ContestantCategory.all) {
      filtered = filtered.where((c) => c.category == selectedCategory.name).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) {
        return c.nameEn.toLowerCase().contains(searchQuery) ||
               c.nameAr.contains(searchQuery) ||
               c.id.toLowerCase().contains(searchQuery);
      }).toList();
    }

    return filtered;
  });
});
