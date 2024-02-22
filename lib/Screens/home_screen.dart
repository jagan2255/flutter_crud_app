import 'package:flutter/material.dart';
import 'package:flutterapi/models/dartmodel.dart';
import 'package:flutterapi/provider/user_prodviders.dart';
import 'package:provider/provider.dart';
import '../APIs/api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  late home_pis homeApi = home_pis();
  late bool _isUpdate = false;
  late String _isUpdateText = "Add";
  late String usid;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<user_provider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text("JV App")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter a title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: "Title", // Corrected property name
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Get the title from the text controller
                    final String title = _textController.text;
                    String status = "error";
                    if (title.isNotEmpty) {
                      // Create a new UserData object
                      final userdata newUser = userdata(title: title);
                      if (_isUpdate) {
                        status = await userProvider.updateUser(newUser, usid);
                      } else {
                        status = await userProvider.createUser(newUser);
                      }
                      // Call the createUser method from userProvider

                      if (status == "success") {
                        // Clear the text field after successful addition
                        _textController.clear();
                        _isUpdateText = "Add";
                        _isUpdate = false;
                        const snackBar = SnackBar(
                          content: Text('Added successfully'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Error adding user'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Please enter a title'),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: _isUpdate ? Text("Update") : Text("Add"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Data List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: userProvider.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final userData = snapshot.data![index];
                          Text(
                            userData.title.toString(),
                          );
                          return ListTile(
                            title: Text(userData.title
                                .toString()), // Example: assuming UserData has a title field
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _textController.text =
                                          userData.title.toString();
                                      _isUpdate = true;
                                      _isUpdateText = "Update";
                                      usid = userData.sId.toString();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.upcoming_sharp,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete Item"),
                                          content: Text(
                                              "Are you sure you want to delete this item?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Delete"),
                                              onPressed: () async {
                                                var status = await userProvider
                                                    .deleteUser(userData.sId);
                                                if (status == "success") {
                                                  Navigator.of(context).pop();
                                                  const snackBar = SnackBar(
                                                    content: Text(
                                                        'Deleted successfully'),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    behavior: SnackBarBehavior
                                                        .floating, // Adjust duration as needed
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                } else {
                                                  Navigator.of(context).pop();
                                                  const snackBar = SnackBar(
                                                    content: Text('Error'),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    behavior: SnackBarBehavior
                                                        .floating, // Adjust duration as needed
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
