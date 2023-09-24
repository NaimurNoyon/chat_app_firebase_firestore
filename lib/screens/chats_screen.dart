import 'package:chat_app/screens/search_screen.dart';
import 'package:chat_app/widgets/user_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UsersSearchScreen())),
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout, color: Colors.black),
            ),
          ],
        ),
        body: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  value.users[index].uid != FirebaseAuth.instance.currentUser?.uid
                ?
                  UserItem(user: value.users[index])
              : const SizedBox(),
              );
        }));
  }
}
