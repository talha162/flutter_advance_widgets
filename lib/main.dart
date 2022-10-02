import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_actions/quick_actions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Advance Widgets")),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final quickActions = QuickActions();

  @override
  void initState() {
    super.initState();
    quickActions.setShortcutItems(
        [const ShortcutItem(type: 'action_help', localizedTitle: "Help")]);
    quickActions.initialize((type) {
      if (type == "action_help") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Help(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Help(),
                  ));
            },
            child: Text("Help"))
      ],
    );
  }
}

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Advance Widgets")),
        body: Column(
          children: [
            Center(child: Text("Help page")),
            Hero(
                tag: "tag1",
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Stepper1(),
                          ));
                    },
                    child: Text("Goto Stepper1 Page"))),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ));
                },
                child: Text("Goto home Page")),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Stepper1(),
                    ));
              },
              child: Hero(
                tag: "tag",
                child: ClipRRect(
                    child: Image.network(
                  "http://images.amazon.com/images/P/1558746218.01.LZZZZZZZ.jpg",
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Stepper1 extends StatefulWidget {
  const Stepper1({Key? key}) : super(key: key);

  @override
  State<Stepper1> createState() => _Stepper1State();
}

class _Stepper1State extends State<Stepper1> {
  int current_Step = 0;
  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Advance Widgets"),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Help"),
                      value: "Help",
                    ),
                    PopupMenuItem(
                      child: Text("Alert"),
                      value: "Alert",
                    )
                  ],
                  onSelected:  (value) {
                    setState(() {
                      if(value=="Help"){
                      Navigator.pop(context);
                      }
                      else if(value=="Alert"){
                        showDialog(context: context, builder:
                        (context) {
                          return AlertDialog(
                            title: Text("Talha Flutter"),
                            actions: [TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Stepper1(),));
                            }, child: Text("Close"))],
                          );
                        },
                        );
                      }
                    });
                  },
                ),
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ChoiceChip(
                    label: Text("Click here",
                        style: TextStyle(color: Colors.blue)),
                    selected: isselected,
                    onSelected: (value) {
                      setState(() {
                        isselected = value;
                      });
                    },
                  ),
                  //will show different interface of sliders for iphone and android as i have used adaptive
                  Hero(
                    child: ClipRRect(
                        child: Image.network(
                            "http://images.amazon.com/images/P/1558746218.01.LZZZZZZZ.jpg")),
                    tag: "tag",
                  ),
                  Slider.adaptive(
                    value: 1,
                    onChanged: (double value) {
                      if (value == 1) {
                        value = 0;
                      } else if (value == 0) {
                        value = 1;
                      }
                    },
                  ),
                  Stepper(
                    steps: [
                      Step(title: Text("Title 1"), content: Text("content 1")),
                      Step(title: Text("title 2"), content: Text("content 2")),
                      Step(title: Text("title 3"), content: Text("content 3"))
                    ],
                    currentStep: current_Step,
                    onStepTapped: (int value) => current_Step = value,
                    onStepContinue: () {
                      if (current_Step != 2) {
                        setState(() {
                          current_Step += 1;
                        });
                      }
                    },
                    onStepCancel: () => {
                      if (current_Step != 0)
                        {
                          setState(() {
                            current_Step -= 1;
                          })
                        }
                    },
                  ),
                  Container(
                      height: 50,
                      width: 100,
                      color: Colors.red,
                      child: InkWell(
                        onTap: (){setState(() {
    Fluttertoast.showToast(msg: " Flutter check clicked",gravity: ToastGravity.BOTTOM);
                        });},
                        child: FittedBox(
                          child: Text(
                            "Flutter Check",
                            style: TextStyle(fontSize: 100, color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            )));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'apple',
    'bnanna',
    'cat',
    'pear',
    'WaterMelon',
    'Dog',
    'Strawberies'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> matchQuery = [];
    for (var terms in searchTerms) {
      if (terms.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(terms);
      }
    }
    return Center(child: Text(matchQuery[0]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var terms in searchTerms) {
      if (terms.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(terms);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(color: Colors.red),
          ),
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
