import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List products = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://soko.titus.co.ke/api/products'));

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
        // Display error message or retry mechanism
      }
      print('Response body: ${response.body}');
    } catch (e) {
      print('Exception while fetching products: $e');
      // Handle exception or display error message
    }
  }

  Future<void> initiatePayment(String productId) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://soko.titus.co.ke/api/mpesa'),
        body: json.encode({'productId': productId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Payment initiated successfully');
        // Handle UI update accordingly****
      } else {
        print('Failed to initiate payment: ${response.statusCode}');
        // Display error message or retry mechanism
      }
    } catch (e) {
      print('Exception while initiating payment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          String imageUrl =
              'https://soko.titus.co.ke/static/images/${products[index][5]}';
          return GestureDetector(
            onTap: () {
              // Handle tapping on product
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      products[index][1],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      products[index][2],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '\$${products[index][3]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.payment),
                          onPressed: () {
                            initiatePayment(products[index][5]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
