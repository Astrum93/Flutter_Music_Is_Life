import 'package:flutter/material.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/data/memory/firebase/firestore/firebase_collection_reference.dart';

class FollowingTabBarView extends StatefulWidget {
  const FollowingTabBarView({super.key});

  @override
  State<FollowingTabBarView> createState() => _FollowingTabBarViewState();
}

class _FollowingTabBarViewState extends State<FollowingTabBarView>
    with FirebaseCollectionReference, FirebaseAuthUser {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userFriendsCollection.doc(displayName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final userFriendsDoc = snapshot.data!;
        var following = userFriendsDoc.get('following');

        return ListView.builder(
          itemCount: following.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.amberAccent),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),

                          // Image.network(
                          //   ,
                          //   fit: BoxFit.cover,
                          //   alignment: Alignment.center,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'userName',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
