import 'UserModel.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  bool isLiked;
  final bool unread;

  Message({this.sender, this.time, this.text, this.isLiked, this.unread});

// YOU CurrentUser

}

final User currentUser = User(
  id: 0,
  name: "hieu",
  imageUrl: 'assets/images/a.jpg',
);
final User user1 = User(
  id: 1,
  name: "denvau",
  imageUrl: 'assets/images/denvay.jpeg',
);
final User user2 = User(
  id: 2,
  name: "huonggiang",
  imageUrl: 'assets/images/huonggiang.jpeg',
);

final User user3 = User(
  id: 3,
  name: "mytam",
  imageUrl: 'assets/images/mytam.jpg',
);
final User user4 = User(
  id: 4,
  name: "sontung",
  imageUrl: 'assets/images/sontung.jpg',
);
final User user5 = User(
  id: 5,
  name: "huonggiang",
  imageUrl: 'assets/images/tranthanh.jpg',
);
List<User> favorites = [user1, user2, user3, user4, user5];

List<Message> chat = [
  Message(
    sender: user1,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: user2,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: user3,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: user4,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: user5,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: user1,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: false,
  )
];
List<Message> message = [
  Message(
    sender: currentUser,
    time: "5:a",
    text: "Hello",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: user1,
    time: "5:a",
    text: "Hi",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: "5:a",
    text: "3",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: "5:a",
    text: "ma",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: user1,
    time: "5:a",
    text: "kot",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: user1,
    time: "5:a",
    text: "ko biet",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: currentUser,
    time: "5:a",
    text:
        "Trung tam ngoai ngu tin hocj tinh gia lai diaj chia 49 cu chinh lan thanh pho pleiku gia lai",
    isLiked: true,
    unread: false,
  ),
  Message(
    sender: user1,
    time: "5:a",
    text:
        "Trung tam ngoai ngu tin hocj tinh gia lai diaj chia 49 cu chinh lan thanh pho pleiku gia lai",
    isLiked: false,
    unread: false,
  )
];
