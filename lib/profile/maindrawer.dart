import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langlearn/profile/model/profile.dart';
import 'package:langlearn/profile/profile_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users/')
          .doc(authenticatedUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('No message found'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        var loadedData = snapshot.data;
        print(loadedData!["username"]);
        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(loadedData["image_url"]),
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(180),
                    radius: 23,
                  ),
                  // leading: Image.network(loadedData["image_url"],fit: BoxFit.cover),
                  title: Text(
                    loadedData["username"],
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          profile: Profile(
                        email: loadedData["email"],
                        imageUrl: loadedData["image_url"],
                        username: loadedData["username"],
                        lat: loadedData["lat"],
                        lng: loadedData["lng"]
                      )),
                    ));
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 26,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                ),  
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
        );
      },
      // child: Drawer(
      //   child: Column(
      //     children: [
      //       DrawerHeader(
      //           padding: const EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               colors: [
      //                 Theme.of(context).colorScheme.primaryContainer,
      //                 Theme.of(context)
      //                     .colorScheme
      //                     .primaryContainer
      //                     .withOpacity(0.8),
      //               ],
      //               begin: Alignment.topLeft,
      //               end: Alignment.bottomRight,
      //             ),
      //           ),
      //           child: Row(
      //             children: [],
      //           ))
      //     ],
      //   ),
      // ),
    );
  }
}
