import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/responsive.dart';

class CategoriesList extends StatefulWidget {
  final Function(String) onCategorySelected;
  const CategoriesList({super.key, required this.onCategorySelected});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  final List<String> categories = [
    'الكل',
    'تكنولوجيا',
    'رياضة',
    'اقتصاد',
    'سياسة',
    'مصر',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: R.h(context, 45),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onCategorySelected(categories[index]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: R.w(context, 4)),
                  padding: EdgeInsets.symmetric(horizontal: R.w(context, 20)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFB71C1C)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(R.radius(context, 25)),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: Colors.grey.shade300,
                            width: R.w(context, 1),
                          ),
                  ),
                  child: Text(
                    categories[index],
                    style: GoogleFonts.cairo(
                      color: isSelected ? Colors.white : Colors.grey[800],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      fontSize: R.sp(context, 14),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
