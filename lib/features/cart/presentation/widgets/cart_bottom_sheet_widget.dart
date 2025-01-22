import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key, required this.totalPrice});

  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          // Bottom sheet handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Customer info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Информация о получателя',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'дальат дальат',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '+7 706 622 3709',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),

          // Delivery info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Доставка',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'asdas',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // const SizedBox(height: 20),
          // const Divider(height: 1),
          // const SizedBox(height: 20),

          // Products
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Товары',
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       const SizedBox(height: 12),
          //       // Standard product
          //       Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey[200]!),
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: Row(
          //           children: [
          //             Container(
          //               width: 60,
          //               height: 60,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[100],
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: const Icon(Icons.shopping_bag_outlined),
          //             ),
          //             const SizedBox(width: 12),
          //             const Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Стандартный товар',
          //                     style: TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                   SizedBox(height: 4),
          //                   Text(
          //                     'Количество: 1',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.grey,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(height: 12),
          //       // Custom product
          //       Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey[200]!),
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               children: [
          //                 Container(
          //                   width: 60,
          //                   height: 60,
          //                   decoration: BoxDecoration(
          //                     color: Colors.grey[100],
          //                     borderRadius: BorderRadius.circular(8),
          //                   ),
          //                   child: const Icon(Icons.cake_outlined),
          //                 ),
          //                 const SizedBox(width: 12),
          //                 const Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         'Кастомный торт',
          //                         style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                       SizedBox(height: 4),
          //                       Text(
          //                         'Количество: 2',
          //                         style: TextStyle(
          //                           fontSize: 14,
          //                           color: Colors.grey,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 const Text(
          //                   '21 ₸',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(height: 12),
          //             Wrap(
          //               spacing: 8,
          //               runSpacing: 8,
          //               children: [
          //                 _buildChip('Синий'),
          //                 _buildChip('Квадратный'),
          //                 _buildChip('Черный торт'),
          //               ],
          //             ),
          //             if (true) ...[
          //               const SizedBox(height: 8),
          //               Text(
          //                 'dsadsadsa',
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   color: Colors.grey[600],
          //                 ),
          //               ),
          //             ],
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Total
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Итого:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$totalPrice ₸',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                elevation: 1.5,
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                shadowColor: Colors.grey.withOpacity(0.3),
              ),
              child: const Text(
                'Заказать',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 14,
        ),
      ),
    );
  }
}
