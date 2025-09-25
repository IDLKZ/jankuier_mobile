import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/parameters/get_tournament_parameter.dart';

class TournamentFiltersWidget extends StatefulWidget {
  final GetTournamentParameter currentParams;
  final Function(GetTournamentParameter) onFiltersChanged;

  const TournamentFiltersWidget({
    super.key,
    required this.currentParams,
    required this.onFiltersChanged,
  });

  @override
  State<TournamentFiltersWidget> createState() => _TournamentFiltersWidgetState();
}

class _TournamentFiltersWidgetState extends State<TournamentFiltersWidget> {
  late TextEditingController _searchController;
  late bool _isMale;
  late bool _showInternational;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.currentParams.search ?? '');
    // _isMale = widget.currentParams.is_male;
    _showInternational = true; // Можно добавить в параметры если нужно
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateFilters() {
    final newParams = GetTournamentParameter(
      page: 1, // Сбрасываем на первую страницу при изменении фильтров
      pageSize: widget.currentParams.pageSize,
      country: widget.currentParams.country,
      is_male: _isMale,
      search: _searchController.text.isEmpty ? null : _searchController.text,
      id: widget.currentParams.id,
      team: widget.currentParams.team,
    );
    
    widget.onFiltersChanged(newParams);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Поиск
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchTournaments,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[500],
                size: 20.sp,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _updateFilters();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey[500],
                        size: 20.sp,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            onChanged: (value) {
              setState(() {});
            },
            onSubmitted: (value) => _updateFilters(),
          ),
          
          SizedBox(height: 16.h),
          
          // Фильтры по полу
          Row(
            children: [
              Expanded(
                child: _buildGenderFilter(
                  label: AppLocalizations.of(context)!.maleTournaments,
                  icon: Icons.male,
                  isSelected: _isMale,
                  onTap: () {
                    setState(() {
                      _isMale = true;
                    });
                    _updateFilters();
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildGenderFilter(
                  label: AppLocalizations.of(context)!.femaleTournaments,
                  icon: Icons.female,
                  isSelected: !_isMale,
                  onTap: () {
                    setState(() {
                      _isMale = false;
                    });
                    _updateFilters();
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          Container(height: 1, color: Colors.grey[100]),
        ],
      ),
    );
  }

  Widget _buildGenderFilter({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[200]!,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? Colors.blue : Colors.grey[600],
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.blue : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}