import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task_it/provider/Auth_service.dart';
import 'package:task_it/screens/Intro/login.dart';
import '/screens/navscreens/homepage/homepage.dart';
import '/constants/custom_colors.dart';
import 'task/tasks_list.dart';
import '/screens/leaderboard/leaderboard.dart';
import '/screens/user_account.dart';
import '/screens/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String appURL =
      "https://play.google.com/store/apps/details?id=com.miu.taskit";
  int currentIndex = 1;
  List navBarPages = [TaskListScreen(), Homepage(), Settings()];

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    final users = FirebaseFirestore.instance.collection('users');
    print(userID);

    // final user = FirebaseAuth.instance.currentUser?.email;
    //     FirebaseFirestore.instance.collection('users').snapshots();
    //final username = FirebaseAuth.instance.currentUser?.displayName;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.dehaze_rounded,
                color: CustomColors.Midnight,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: CustomColors.Cultured,
        elevation: 0,
        title: FutureBuilder<DocumentSnapshot>(
          future: users.doc(userID).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text("Hello, ${data['Full Name']}",
                  style: TextStyle(color: CustomColors.Midnight, fontSize: 20));
            }
            return Text("user");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFF1E4E5F),
            ),
            iconSize: 30,
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            },
          )
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(userID).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: CustomColors.Midnight),
                      accountName: Text('${data['Full Name']}'),
                      accountEmail: Text('${data['email']}'),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: CustomColors.Midnight,
                        radius: 50,
                        child: ClipOval(
                            child: new SizedBox(
                                width: 90.0,
                                height: 90.0,
                                child: Image.network(
                                  data['Photo URL'],
                                  fit: BoxFit.fill,
                                ))),
                      ),
                    ),
                  ],
                );
              }
              return Text("loading");
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text("Profile"),
            onTap: () => {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Account()))
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active_rounded),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.leaderboard_rounded),
            title: Text("Leaderboard"),
            onTap: () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => LeaderBoardScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp),
            title: Text("Logout"),
            onTap: () {
              final check = context.read<AuthenticationService>().signOut();
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          Divider(
            thickness: 1,
            height: 90,
            color: Colors.grey,
          ),
          ListTile(
            leading: Container(
              child: ElevatedButton.icon(
                icon: Icon(Icons.share_rounded),
                onPressed: () {
                  Share.share(appURL);
                },
                label: Text("Share App"),
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(20),
                    primary: CustomColors.Midnight),
              ),
            ),
          ),
        ],
      )),
      body: navBarPages[currentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(30)),
              child: BottomNavigationBar(
                selectedItemColor: CustomColors.Midnight,
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    label: "Tasks",
                    icon: Icon(Icons.apps_rounded, size: 30),
                  ),
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home_rounded, size: 30),
                  ),
                  BottomNavigationBarItem(
                    label: "Settings",
                    icon: Icon(Icons.more_horiz, size: 30),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _newTaskDialog(BuildContext context) {
    TextEditingController _title = TextEditingController();
    TextEditingController _description = TextEditingController();

    Widget createButton = TextButton(
      child: Text("Create Task"),
      onPressed: () {
        // Provider.of<TasksProvider>(context, listen: false)
        //     .createTask(_title.text, _description.text);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Add a new task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration: InputDecoration(hintText: "Enter Title"),
          ),
          TextField(
            controller: _description,
            decoration: InputDecoration(hintText: "Enter Description"),
          ),
        ],
      ),
      actions: [
        createButton,
      ],
    );

    // showMaterialModalBottomSheet(
    //     // add button add w add task fi al set state?
    //     elevation: 10,
    //     backgroundColor: Colors.amber,
    //     context: ctx,
    //     builder: (ctx) => Container(
    //           //width: 100,
    //           height: 800,
    //           color: Colors.white,
    //           alignment: Alignment.center,
    //           child: AddTaskScreen(),
    //         ));
  }
}
