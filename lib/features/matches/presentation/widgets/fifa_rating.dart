import 'package:flutter/material.dart';

class FifaRankingEntry {
  final int position;
  final String country;
  final String logoUrl;

  FifaRankingEntry({
    required this.position,
    required this.country,
    required this.logoUrl,
  });
}

class FifaRankingList extends StatelessWidget {
  final String title;
  final List<FifaRankingEntry> entries;

  const FifaRankingList({
    Key? key,
    required this.title,
    required this.entries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          ...entries.map((entry) => _RankingRow(entry: entry)).toList(),
        ],
      ),
    );
  }
}

class _RankingRow extends StatelessWidget {
  final FifaRankingEntry entry;

  const _RankingRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              entry.position.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 26,
            width: 26,
            child: Image.network(
              entry.logoUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.flag_outlined, size: 22, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            entry.country,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
