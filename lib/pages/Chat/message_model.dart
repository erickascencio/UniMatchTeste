import 'package:unimatchteste/pages/Chat/user_model.dart';

class Message{
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });
}
// NÓS
final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/image/greg.jpg'
);

// OUTROS USUÁRIOS
final User greg = User(
    id: 1,
    name: 'Greg',
    imageUrl: 'assets/image/greg.jpg'
);
final User james = User(
    id: 2,
    name: 'James',
    imageUrl: 'assets/image/james.jpg'
);
final User john = User(
    id: 3,
    name: 'John',
    imageUrl: 'assets/image/john.jpg'
);
final User olivia = User(
    id: 4,
    name: 'Olivia',
    imageUrl: 'assets/image/olivia.jpg'
);
final User sam = User(
    id: 5,
    name: 'Sam',
    imageUrl: 'assets/image/sam.jpg'
);
final User sophia = User(
    id: 6,
    name: 'Sophia',
    imageUrl: 'assets/image/sophia.jpg'
);
final User steven = User(
    id: 7,
    name: 'Steven',
    imageUrl: 'assets/image/steven.jpg'
);

List<User> favorites = [sam, steven, olivia, john, greg];

//MENSAGENS NA TELA DE HOME DO CHAT
List<Message> messages = [
  Message(
    sender: james,
    time: '17:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '16:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '15:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '14:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '13:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30',
    text: 'Opa, bão?',
    isLiked: false,
    unread: false,
  ),
];

//MENSAGENS NA TELA DE CHAT chat
List<Message> chats = [
  Message(
    sender: james,
    time: '13:06',
    text: 'Tmjj',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '13:00',
    text: 'Fechow gay',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '12:40',
    text: 'Marcamos certinho depois ',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: james,
    time: '12:40',
    text: 'Vou ver e te aviso man, mas acho que da',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '12:30',
    text: 'Bem tbm, ora resenha mais tarde?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: james,
    time: '12:00',
    text: 'Tudo bem e vc?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: currentUser,
    time: '11:50',
    text: 'Opa, bão?',
    isLiked: false,
    unread: false,
  ),
];