import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var categoryName,  bannerImage, image, productName, brandName, stock, productPrice, productReview ;

  var demoImage = 'https://d3jf6a0vqxxyu1.cloudfront.net/media/brand_images/Suzuki.png';

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

  discount(){
    double discountedPrice = productPrice *0.5;
    return discountedPrice.toString();
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
      appBar: AppBar(
        title: Text("Product Deatails", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined),
            color: Colors.black,
            iconSize: 30,
          ),
        ],),
      backgroundColor: Color(0xFFD2EDF8),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 650,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))
              ),
              child: Column(
                children: [
                  ImageSlideshow(
                    width: double.infinity,
                    height: 300,
                    initialPage: 0,
                    indicatorColor: Colors.blue,
                    indicatorBackgroundColor: Colors.grey,
                    children: [
                      Image.network(image != null ? image : demoImage),
                      Image.network(bannerImage != null ? bannerImage : demoImage),
                      Image.network(image != null ? image : demoImage),
                    ],
                    autoPlayInterval: 3000,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(categoryName != null ? "Category Name: "+ categoryName.toString() + "\n" +
                              "Product Name: "+ productName.toString() + "\n"+ "Brand Name: " + brandName.toString() + "\n"+
                              "Stock: " +stock.toString()   : "Loading ",
                            style: TextStyle(fontFamily: 'Roboto',fontSize: 23),),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text(productPrice != null ? "BDT " + productPrice.toString()  : "Loading ",
                              style: TextStyle(color: Colors.red, fontFamily: 'Roboto',fontSize: 28, fontWeight: FontWeight.bold),),
                            SizedBox(width: 30,),
                            Text(discount(),
                              style: TextStyle(fontFamily: 'Roboto',fontSize: 20,
                                decorationColor: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),),
                            SizedBox(width: 30,),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 80,
                              child: Text("50% Off",
                              style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                              decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Black', style: TextStyle(color: Colors.black),),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black38,
                                side: BorderSide(width: 2.0, color: Colors.black45),
                              ),
                            ),
                            SizedBox(width: 10,),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Yellow', style: TextStyle(color: Colors.yellow),),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.yellow,
                                side: BorderSide(width: 2.0, color: Colors.yellow),
                              ),
                            ),
                            SizedBox(width: 10,),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Red', style: TextStyle(color: Colors.red),),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.red,
                                side: BorderSide(width: 2.0, color: Colors.red),
                              ),
                            ),
                            SizedBox(width: 10,),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Blue', style: TextStyle(color: Colors.blue),),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.blue,
                                side: BorderSide(width: 2.0, color: Colors.blue),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 25, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Delivery Information",   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                   children: [
                     Icon(
                       Icons.shopping_cart_outlined,
                       color: Colors.orange,
                       size: 24.0,
                       semanticLabel: 'Text to announce in accessibility modes',
                     ),
                     Text("Sent from ", style: TextStyle(fontSize: 18,)),
                     Text("Dhaka,", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,)),
                     Text(" will arrive in ", style: TextStyle(fontSize: 18,)),
                     Text("7/10 ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,)),
                     Text("workdays", style: TextStyle(fontSize: 18,)),
                   ],
                 ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Payment Method (Supported",   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("\u{2714} Bkash", style: TextStyle(fontSize: 20,)),
                      SizedBox(width: 20,),
                      Text('\u{274C} Cash on delivery not available', style: TextStyle(fontSize: 20,))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("\u{2714} Bkash", style: TextStyle(fontSize: 20,)),
                      SizedBox(width: 20,),
                      Text('\u{2714} Bkash', style: TextStyle(fontSize: 20,)),
                      SizedBox(width: 20,),
                      Text('\u{2714} Bkash', style: TextStyle(fontSize: 20,))
                    ],
                  ),
                  SizedBox(height: 20,),
                  ExpansionTile(
                    title: Text('Description', textAlign: TextAlign.start,   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    children: <Widget>[
                      ListTile(title: Text('\u{25FE} Soft-touch jersy')),
                      ListTile(title: Text('\u{25FE} Lose Fabric')),
                      ListTile(title: Text('\u{25FE} High Sensitive')),
                      ListTile(title: Text('\u{25FE} Soft-touch jersy')),
                      ListTile(title: Text('\u{25FE} Lose Fabric')),
                      ListTile(title: Text('\u{25FE} High Sensitive')),

                    ],
                  ),
                  ExpansionTile(
                    title: Text('Additional Information', textAlign: TextAlign.start,   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    children: <Widget>[
                      ListTile(title: Text('\u{25FE} L,M,S,XL')),
                      ListTile(title: Text('\u{25FE} Colors: Black, Blue, Red')),
                    ],
                  ),
                  SizedBox(height: 100,),
                  Container(
                    child: Text("Contact\n\u{1F4E7} jahid.h.sagor@gmail.com",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(height: 50,)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
