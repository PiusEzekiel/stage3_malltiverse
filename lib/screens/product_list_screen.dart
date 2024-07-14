import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage2_product_app/models/product.dart';
import 'package:stage2_product_app/services/timbu_api_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TimbuApiService _apiService = TimbuApiService();
  List<Product> products = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  String? organizationId; // Replace with your organization ID

  final String? imageBaseUrl = dotenv.env['imageBaseUrl'];

  @override
  void initState() {
    super.initState();
    organizationId = '2d75e315be3449b582428837ea8e9e1b';
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });
    try {
      if (organizationId != null) {
        products =
            await _apiService.fetchProducts(organizationId: organizationId!);
        setState(() {
          isLoading = false;
        });
      } else {
        // Handle the case where organizationId is null
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = 'Invalid organization ID';
        });
      }
    } catch (error) {
      // print('Error fetching products: $error');
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Failed to load products. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            children: [
              Image(image: AssetImage('assets/Malltiverse Logo.png')),
              SizedBox(width: 30),
              Text(
                'Product List',
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchProducts,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(errorMessage),
                        ElevatedButton(
                          onPressed: _fetchProducts,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 232,
                          width: MediaQuery.of(context).size.width,
                          // width: 600,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Your image or other widget
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/#Headphones.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              // Your interactive child widget
                              Positioned(
                                top: 60,
                                left: 25, // Position the widget at the bottom
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Premium Sound,",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w900,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                    Text(
                                      "Premium Savings",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w900,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Limited offer, hope on and get yours now",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 40.0,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Tech Gadget",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      //will change the aspect ratio to 9/18
                                      childAspectRatio: 9 / 18),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                // print(product); // Print the product to the console

                                if (product.photos.isNotEmpty) {
                                  final firstPhoto = product.photos[0];
                                  final fullImageUrl =
                                      imageBaseUrl! + firstPhoto.url!;
                                  return Material(
                                    // elevation: 3,
                                    // color: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        // borderRadius: BorderRadius.circular(20),
                                        ),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigate to product details screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                    product: product),
                                          ),
                                        );
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius
                                                  .only(
                                                  // topLeft: Radius.circular(20),
                                                  // topRight: Radius.circular(20),
                                                  ), // Only top corners rounde
                                              child: Container(
                                                height: 185,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  // widthFactor: 2,
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: Image.network(
                                                      fullImageUrl,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const Icon(
                                                            Icons.error);
                                                      },
                                                      width:
                                                          30, // Adjust image width
                                                      height:
                                                          80, // Adjust image height
                                                      fit: BoxFit
                                                          .fitHeight, // Ensure image covers the space
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //   ??
                                            // const Icon(Icons.image_not_supported);

                                            //name of the product
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                // horizontal: 12,
                                                top: 12,
                                              ),
                                              child: Text(
                                                product.name ?? 'No name',
                                                style: TextStyle(
                                                  fontSize:
                                                      12, // Adjust font size
                                                  // fontFamily: "Montserrat",
                                                  fontWeight: FontWeight
                                                      .bold, // Make title bold
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                // horizontal: 12,
                                                top: 4,
                                              ),

                                              //description of the product
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                product.description ??
                                                    'No description',
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Montserrat',
                                                  // maxLines: 1,
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                // horizontal: 12,
                                                top: 6,
                                              ),

                                              //price of the product
                                              child: Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 18),
                                                  Icon(Icons.star,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 18),
                                                  Icon(Icons.star,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 18),
                                                  Icon(Icons.star,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 18),
                                                  Icon(Icons.star,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 18),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  // horizontal: 12,
                                                  vertical: 12,
                                                ), // Add some spacing between title and price

                                                child: Text(
                                                  '\N ${product.currentPrice[0].amount ?? 0.0}',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary // Make price slightly bold
                                                      ),
                                                )),
                                            OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                // primary: Colors.blueGrey.shade600,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                side: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  style: BorderStyle.solid,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String imageBaseUrl = dotenv.env['imageBaseUrl']!;

    final firstPhoto = product.photos[0];
    final fullImageUrl = imageBaseUrl + firstPhoto.url!;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Buy ${product.name}!         ",
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ))),
      ),
      //
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(
                      2,
                      2,
                    ),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                // Match the Container's borderRadius
                child: Image.network(
                  fullImageUrl, // Make sure you have the correct URL here
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                  fit: BoxFit.cover, // Ensure the image fills the space
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 12,
            //     vertical: 4,
            //   ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (130),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ), //name of the product
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.name ?? 'No name',
                          style: TextStyle(
                            fontSize: 30, // Adjust font size
                            fontWeight: FontWeight.bold, // Make title bold
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${product.currentPrice[0].amount ?? 0.0}',
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.red, // Make price slightly bold
                          ),
                        )
                      ],
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 4,
                    //   ),

                    const SizedBox(
                        height:
                            10), // Add some spacing between title and description
                    //description of the product
                    Text(
                      product.description ?? 'No description',
                      style: const TextStyle(fontSize: 22.0),
                    ),

                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade600,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
