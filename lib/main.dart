import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Model class
class ProductModel {
  String productName;
  int price;
  bool isSelected;
  ProductModel(this.productName, this.price, this.isSelected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          productName == other.productName;
}

//Provider class
class ProductModelProvider extends ChangeNotifier {
  final List<ProductModel> _productModelList = [];
  void initialSetup() {
    _productModelList.add(ProductModel("T-Shirt", 399, false));
    _productModelList.add(ProductModel("Jeans", 999, false));
    _productModelList.add(ProductModel("Socks", 99, false));
    _productModelList.add(ProductModel("Shirt", 499, false));
  }

  void productClicked(index) {
    _productModelList.elementAt(index).isSelected =
        !_productModelList.elementAt(index).isSelected;
    notifyListeners();
  }

  List<ProductModel> get productModelList => _productModelList;
  List<ProductModel> get selectedProductList =>
      productModelList.where((element) => element.isSelected).toList();
}

//main app starting point
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductModelProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //listen false is mandatory as we are outside the build
    Provider.of<ProductModelProvider>(context, listen: false).initialSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProductModelProvider>(
        builder: (context, productProvider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: productProvider.productModelList.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(productProvider.productModelList
                            .elementAt(index)
                            .productName),
                        subtitle: Text(productProvider.productModelList
                            .elementAt(index)
                            .price
                            .toString()),
                        trailing: productProvider.productModelList
                                .elementAt(index)
                                .isSelected
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                        onTap: () => productProvider.productClicked(index),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cart",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: productProvider.selectedProductList.length,
                    itemBuilder: (_, index) {
                      return Text(
                        productProvider.selectedProductList
                            .elementAt(index)
                            .productName,
                        style: TextStyle(fontSize: 22),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}
