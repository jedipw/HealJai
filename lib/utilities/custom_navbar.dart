import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final Color selectedItemColor;
  final ValueChanged<int> onTap;

  CustomBottomNavigationBar({
    required this.items,
    required this.selectedItemColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8, top: 12), // Adjust the bottom padding as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                final index = items.indexOf(item);
                onTap(index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32,
                    child: item.icon,
                  ),
                  const SizedBox(
                      height:
                          4), // Adjust the spacing between icon and label as needed
                  Text(
                    item.label!,
                    style: TextStyle(
                      color: selectedItemColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
