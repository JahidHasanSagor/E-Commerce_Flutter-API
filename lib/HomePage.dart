import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var categoryName,  bannerImage, image, productName, brandName, stock, productPrice, productReview ;

  var imagedemo = 'https://d3jf6a0vqxxyu1.cloudfront.net/media/images/product/None/21/Suzuki-GSX-R150.jpeg';

  Future<void> getApiData() async{
    http.Response response = await http.get(Uri.parse("http://3.1.180.10/api/product-core/suzuki-gsx-r150-fi-dual-channel-abs-yvj2/0/"));
    var result = jsonDecode(response.body);

    setState(() {
      this.stock = result ['stock'];
      this.image = result ['image'];
      this.bannerImage = result ['banner_image'];
      this.categoryName = result ['category_list'] [0] ['category_name'];
      this.productName = result ['product_name'] ;
      this.brandName = result ['brand'] ['name'];
      this.productPrice = result ['product_price'];
      this.productReview = result ['product_review_avg'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Deatails", style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
      body:SingleChildScrollView(
        child: Column(
          children: [
            ImageSlideshow(
              width: double.infinity,
              height: 300,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              children: [
                Image.network(imagedemo),
                Image.network(image != null ? image : 'https://d3jf6a0vqxxyu1.cloudfront.net/media/brand_images/Suzuki.png'),
                Image.network(bannerImage != null ? bannerImage : imagedemo),
              ],
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              autoPlayInterval: 4000,
            ),
            Text(stock != null ? stock.toString()  : "Loading"),
            Text(categoryName != null ? categoryName.toString()  : "Loading "),
            Text(productName != null ? productName.toString()  : "Loading "),
            Text(brandName != null ? brandName.toString()  : "Loading "),
            Text(productPrice != null ? productPrice.toString()  : "Loading "),
            Text(productReview != null ? productReview.toString()  : "Loading "),

          ],
        ),
      ),
    );
  }
}
