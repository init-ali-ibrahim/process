// import 'package:initMobi/core/entity/message.dart';
//
// class MessageUtils {
//   static List<List<Message>> groupBySenderAndDate(List<Message> messages) {
//     List<List<Message>> groups = [];
//     List<Message> currentGroup = [];
//
//     for (var msg in messages) {
//       if (currentGroup.isEmpty) {
//         currentGroup.add(msg);
//         continue;
//       }
//
//       final lastMessage = currentGroup.last;
//
//       final isSenderEqual = lastMessage.senderId == msg.senderId;
//
//       final msgDate = msg.createdAt.add(Duration(minutes: 5));
//       final isInDateRange = msgDate.isAfter(lastMessage.createdAt);
//
//       if (isSenderEqual && isInDateRange) {
//         currentGroup.add(msg);
//       } else {
//         groups.add(List.from(currentGroup)); // Add the current group
//         currentGroup = [msg]; // Start a new group with the current message
//       }
//     }
//
//     if (currentGroup.isNotEmpty) {
//       groups.add(List.from(currentGroup));
//     }
//
//     return groups;
//   }
// }