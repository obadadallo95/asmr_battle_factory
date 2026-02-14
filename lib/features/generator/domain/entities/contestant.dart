// Lines: 30/300
import 'package:equatable/equatable.dart';


enum ContestantCategory {
  all,
  insects,
  wildAnimals,
  marineLife,
  metals,
  elements,
  stationery,
  food,
  mythical,
  tech,
}

class Contestant extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final ContestantCategory category;
  final String iconAsset;
  final List<String> strengths;
  final List<String> weaknesses;
  final double powerLevel;

  const Contestant({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.category,
    required this.iconAsset,
    required this.strengths,
    required this.weaknesses,
    required this.powerLevel,
  });

  factory Contestant.fromJson(Map<String, dynamic> json) {
    return Contestant(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      category: ContestantCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ContestantCategory.wildAnimals,
      ),
      iconAsset: json['iconAsset'] as String,
      strengths: List<String>.from(json['strengths']),
      weaknesses: List<String>.from(json['weaknesses']),
      powerLevel: (json['powerLevel'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, nameAr, nameEn, category, iconAsset, strengths, weaknesses, powerLevel];

  Contestant copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    ContestantCategory? category,
    String? iconAsset,
    List<String>? strengths,
    List<String>? weaknesses,
    double? powerLevel,
  }) {
    return Contestant(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      category: category ?? this.category,
      iconAsset: iconAsset ?? this.iconAsset,
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      powerLevel: powerLevel ?? this.powerLevel,
    );
  }
}
