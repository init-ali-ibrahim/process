import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedCity = 'Алматы';
  List<String> selectedCategories = [
    'Restaurants',
    'Shopping',
    'Entertainment',
    'Services',
  ];

  final List<String> cities = [
    'Алматы',
    'Астана',
    'Петропавслк',
    'Актобе',
  ];

  final List<String> categories = [
    'Restaurants',
    'Shopping',
    'Entertainment',
    'Services',
  ];

  void _showFilterMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setMenuState) {
            return Dialog(
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 1), spreadRadius: 1.5, blurRadius: 5),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 1), spreadRadius: 1.5, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Cities',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 12,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: cities.map((city) {
                                final isSelected = selectedCity == city;
                                return ChoiceChip(
                                  selected: isSelected,
                                  label: Text(city),
                                  showCheckmark: false,
                                  selectedColor: Colors.red,
                                  elevation: 1,
                                  surfaceTintColor: Colors.grey,
                                  backgroundColor: Colors.grey[100],
                                  side: BorderSide.none,
                                  labelStyle: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      setMenuState(() {
                                        setState(() {
                                          selectedCity = city;
                                        });
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 1), spreadRadius: 1.5, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 12,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...categories.map((category) {
                                  final isSelected = selectedCategories.contains(category);
                                  return FilterChip(
                                    selectedColor: Colors.red,
                                    elevation: 1,
                                    surfaceTintColor: Colors.grey,
                                    backgroundColor: Colors.grey[100],
                                    side: BorderSide.none,
                                    showCheckmark: false,
                                    selected: isSelected,
                                    label: Text(category),
                                    labelStyle: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                    onSelected: (bool selected) {
                                      setMenuState(() {
                                        setState(() {
                                          if (selected) {
                                            selectedCategories.add(category);
                                          } else {
                                            selectedCategories.remove(category);
                                          }
                                        });
                                      });
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      margin: const EdgeInsets.only(right: 14, left: 14, bottom: 20),
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          elevation: 1.5,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - (kToolbarHeight + 80),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade200),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  spreadRadius: 1.5,
                ),
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Что будем искать?',
                            hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.tune),
                            // if (selectedCategories)
                            //   Positioned(
                            //     right: 0,
                            //     top: 0,
                            //     child: Container(
                            //       height: 10,
                            //       width: 10,
                            //       padding: const EdgeInsets.all(4),
                            //       decoration: const BoxDecoration(
                            //         color: Colors.red,
                            //         shape: BoxShape.circle,
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        onPressed: _showFilterMenu,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text('Search Result ${index + 1}'),
                        subtitle: Text('${selectedCategories.isEmpty ? "All Categories" : selectedCategories.join(", ")} • ${selectedCity ?? "All Cities"}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class SearchBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const SearchScreen();
      },
    );
  }
}
