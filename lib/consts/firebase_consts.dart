import 'package:emart_app/consts/consts.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections

const usersCollection = "users";
const productsCollection = "products";
const cartCollection = "cart";
const messagesCollection = "messages";
const chatsCollection = "chats";

const orderCollection = "orders";