import 'package:personajes_star_war/models/people.dart';

class PaginatedResult {
  PaginatedResult({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<People> results;

  factory PaginatedResult.fromJson(Map<String, dynamic> json) => PaginatedResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<People>.from(json["results"].map((x) => People.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
