import 'package:flutter/material.dart';
import 'package:shopping_cart/cart.dart';
import 'package:shopping_cart/dish.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dish> dishes = [
    Dish(name: 'Apple & Blackberry Crumble'),
    Dish(name: 'Banana Pancakes'),
    Dish(name: 'Carrot Cake'),
    Dish(name: 'Lasagne'),
    Dish(name: 'Grilled Mac and Cheese Sandwich'),
    Dish(name: 'Fettucine alfredo'),
    Dish(name: 'Mediterranean Pasta Salad'),
    Dish(name: 'Salmon Avocado Salad'),
    Dish(name: 'Fish pie'),
    Dish(name: 'French Onion Soup'),
    Dish(name: 'Tomato Soup'),
    Dish(name: 'Cheese Tart'),
    Dish(name: 'Breakfast Potatoes'),
    Dish(name: 'Chicken Handi'),
    Dish(name: 'Shawarma'),
    Dish(name: 'Tandoori chicken'),
  ];

  List<Dish> addedDishes = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Dishes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: ListView.separated(
          itemCount: dishes.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (context, index) => ListTile(
            shape: Border.all(width: 1.0, color: Colors.black),
            title: Text(dishes[index].name),
            leading: const CircleAvatar(child: Text('CB')),
            trailing: IconButton(
                color: Colors.blue,
                onPressed: () async {
                  bool removeDish = false;
                  if (!dishes[index].addToCart) {
                    dishes[index].addToCart = true;
                    addedDishes.add(dishes[index]);
                    setState(() {});
                  } else {
                    removeDish = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                  'Do you want to delete ${dishes[index].name}?'),
                              content: const Text(
                                  'The following dish will be removed from your cart'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('No'))
                              ],
                            ));

                    if (removeDish) {
                      addedDishes.remove(dishes[index]);
                      dishes[index].addToCart = false;
                      setState(() {});
                    }
                  }
                },
                icon: dishes[index].addToCart
                    ? const Icon(Icons.remove_circle)
                    : const Icon(Icons.add_circle)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Cart(
                dishes: addedDishes,
                onListUpdate: (list) {
                  addedDishes = list;
                  setState(() {});
                }))),
        tooltip: 'My Shopping Cart',
        child: const Text('Cart'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
