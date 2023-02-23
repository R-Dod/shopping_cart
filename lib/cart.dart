import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shopping_cart/dish.dart';

import 'main.dart';

class Cart extends StatefulWidget {
  final Function(List<Dish>) onListUpdate;
  final List<Dish> dishes;

  const Cart({Key? key, required this.dishes, required this.onListUpdate})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Dish> _dishes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dishes = widget.dishes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: ListView.separated(
                itemCount: _dishes.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) => ListTile(
                  shape: Border.all(width: 1.0, color: Colors.black),
                  title: Text(_dishes[index].name),
                  leading: const CircleAvatar(child: Text('CB')),
                  trailing: IconButton(
                      color: Colors.blue,
                      onPressed: () async {
                        bool removeDish = false;
                        removeDish = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      'Do you want to delete ${_dishes[index].name}?'),
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
                          _dishes[index].addToCart = false;
                          _dishes.remove(_dishes[index]);
                          widget.onListUpdate(_dishes);
                          setState(() {});
                        }
                      },
                      icon: _dishes[index].addToCart
                          ? const Icon(Icons.remove_circle)
                          : const Icon(Icons.add_circle)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
