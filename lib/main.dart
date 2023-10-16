import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ListItem {
  String title;
  String subtitle;

  ListItem({required this.title, required this.subtitle});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ListItem> items = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Icon(
            Icons.search,
            color: Colors.blue,
          )
        ],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Add Title",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: subtitleController,
              decoration: InputDecoration(
                  hintText: "Add Description",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1))),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  items.add(ListItem(
                      title: titleController.text,
                      subtitle: subtitleController.text));
                  titleController.text = "";
                  subtitleController.text = "";
                  FocusScope.of(context).unfocus();
                  setState(() {});
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      title: Text(items[index].title),
                      trailing: const Icon(Icons.arrow_forward),
                      subtitle: Text(items[index].subtitle),
                      onLongPress: () {
                        _showOptionsDialog(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Alert",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _showEditBottomSheet(index);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditBottomSheet(int index) {
    TextEditingController titleController =
        TextEditingController(text: items[index].title);
    TextEditingController subtitleController =
        TextEditingController(text: items[index].subtitle);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    items[index].title = titleController.text;
                    items[index].subtitle = subtitleController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Edit Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
