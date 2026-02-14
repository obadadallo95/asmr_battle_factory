import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';

abstract class ContestantRepository {
  Future<List<Contestant>> getAll();
  Future<Contestant?> getById(String id);
}

@LazySingleton(as: ContestantRepository)
class ContestantRepositoryImpl implements ContestantRepository {
  List<Contestant>? _cache;

  @override
  Future<List<Contestant>> getAll() async {
    if (_cache != null) return _cache!;

    try {
      final jsonString = await rootBundle.loadString('assets/data/contestants.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> list = jsonData['contestants'];
      
      _cache = list.map((e) => Contestant.fromJson(e)).toList();
      return _cache!;
    } catch (e) {
      throw Exception('Failed to load contestants: $e');
    }
  }

  @override
  Future<Contestant?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
