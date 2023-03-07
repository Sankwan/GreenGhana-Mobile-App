import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

//working
class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List seedlingInfo = [];

  var dio = Dio();

  getItems() async {
    var response = await dio.get('https://fakestoreapi.com/products');
    var data = response.data;
    setState(() {
      seedlingInfo = data;
    });
    logger.d(seedlingInfo);
  }

  @override
  void initState() {
    getItems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //this is a package
    return CarouselSlider(
      items: [
        //1st Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/c/ca/Starr_010304-0485_Tectona_grandis.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
          ),
        ),

        //2nd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://i0.wp.com/www.chiangmai-alacarte.com/wp-content/uploads/2021/09/EAC-teak-tree.jpg?fit=800%2C600&ssl=1"),
              fit: BoxFit.cover,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
          ),
        ),

        //3rd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://www.healthbenefitstimes.com/9/uploads/2019/06/Health-benefits-of-Common-teak.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
          ),
        ),

        //4th Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://media.istockphoto.com/id/1168004141/photo/green-leaf-teak-tree.jpg?s=612x612&w=0&k=20&c=ENKhwFBUzLGfmH7Ltbmi7uG2nIz8tSKafQALhgTPje8="),
              fit: BoxFit.cover,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
          ),
        ),

        //5th Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.xxl.thumbs.canstockphoto.com/teak-leaves-green-teak-leaves-at-the-teak-plantation-stock-images_csp15041951.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
          ),
        ),
      ],

      //Slider Container properties
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
