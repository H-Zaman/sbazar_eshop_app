import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbazar/others/resources/colors.dart';

import 'home_page.dart';

class FarmPage extends StatefulWidget {
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {

  late ScrollController _scrollController;

  bool safeArea = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {
      if(_scrollController.offset > Get.height * .4){
        if(!safeArea){
          setState(() {
            safeArea = true;
          });
        }
      }else{
        if(safeArea){
          setState(() {
            safeArea = false;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: safeArea ? AppColor.kMainColor : Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: AnimatedCrossFade(
          firstChild: Text(
            'farm.farmName'.trim().capitalize!
          ),
          secondChild: SizedBox(),
          duration: Duration(milliseconds: 200),
          crossFadeState: safeArea ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        actions: [
          CartButton(color : safeArea ? Colors.white : null)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
          controller: _scrollController,
          physics: ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      _FarmInfo(/*farm: farm*/)
                    ]
                ),
              ),
            ];
          },
          body: _farmProducts()
      ),
    );
  }
}


class _FarmInfo extends StatelessWidget {
  // final farmModel farm;
  // const _farmInfo({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*.5,
      child: Column(
        children: [
          Expanded(
            flex: 81,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider('https://images.unsplash.com/photo-1534723452862-4c874018d66d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c3RvcmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: Color(0xff152238).withOpacity(.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'farm.farmName'.trim().capitalize!,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  color: Colors.grey[200],
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'farm.address',
                                    style: TextStyle(
                                        color: Colors.grey[200]
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: .7,
                        color: Colors.white38,
                      ),
                      Container(
                        height: Get.height*.07,
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: double.infinity,
                              width: Get.width * .33,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          CupertinoIcons.money_dollar,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          'Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                              height: 1.4
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      ' \$\$\$',
                                      style: TextStyle(
                                          color: Colors.grey[200]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: .7,
                              height: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              color: Colors.white38,
                            ),
                            Container(
                              height: double.infinity,
                              width: Get.width * .33,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.restaurant,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          'Products',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                              height: 1.4
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      ' 500 Items',
                                      style: TextStyle(
                                          color: Colors.grey[200]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: .7,
                              height: double.infinity,
                              color: Colors.white38,
                              margin: EdgeInsets.symmetric(vertical: 5),
                            ),
                            GestureDetector(
                              onTap: () {
                                // if(widget.basicData.reviews.length == 0){
                                //   Snack.top('Sorry!', 'This restaurant has to reviews yet');
                                // }else{
                                //   Get.to(()=>RestaurantReviewScreen(data: widget.basicData, index: widget.index));
                                // }
                              },
                              child: Container(
                                height: double.infinity,
                                width: Get.width * .33,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.star_fill,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            // '${widget.basicData.rating.toStringAsFixed(1)}',
                                            '4.5',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                                height: 1.4
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        // ' ${widget.basicData.ratingCount} Ratings',
                                        ' 123 Ratings',
                                        style: TextStyle(
                                            color: Colors.grey[200]
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 19,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              color: AppColor.kMainColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Tags: ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      Wrap(
                        children: List.generate(4, (index) => Text(
                            'tag ,',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                            )
                        )),
                      )
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: widget.basicData.description == null || widget.basicData.description.length == 0 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'About: ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      Expanded(
                        child: Text(
                          // widget.basicData.description == null || widget.basicData.description.length == 0 ?
                          // 'No description given.'
                          //     :
                          // ' ${widget.basicData.description} ',
                          'No description given.',
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _farmProducts extends StatelessWidget {
  const _farmProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 12, left: 16, right: 16),
        itemBuilder: (_, index) => ProductCard(/*product: farmViewModel.products[index]*/),
        separatorBuilder: (_, __) => Container(
          color: AppColor.kCardBackgroundColor,
          height: 8,
        ),
        itemCount: 12
    );
  }
}

class ProductCard extends StatefulWidget {
  // final ProductModel product;
  // const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 760/260,
      child: Container(
        // height: 110,
        // width: double.infinity,
        decoration: BoxDecoration(
            color: AppColor.kWhiteColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [

            Stack(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4'),
                      fit: BoxFit.cover
                    )
                  ),
                ),

                Positioned(
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
                    child: Text(
                      '20 %',
                      style: TextStyle(
                          color: AppColor.kWhiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    decoration: BoxDecoration(color: AppColor.kMainColor, borderRadius: BorderRadius.circular(3)),
                  ),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    // color: Colors.red,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          'product.productName'.trim().capitalize!,
                          style: TextStyle(
                              color: AppColor.kMainTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        // SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Desc',
                                      style: TextStyle(
                                          color: AppColor.kLightTextColor,
                                          fontSize: 12
                                      )
                                  ),
                                  Text(
                                      'product.description',
                                      style: TextStyle(
                                          color: AppColor.kMainTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Unit',
                                    style: TextStyle(
                                        color: AppColor.kLightTextColor,
                                        fontSize: 12
                                    )
                                ),
                                Text(
                                    'product.unit',
                                    style: TextStyle(
                                        color: AppColor.kMainTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'BDT 123',
                                style: TextStyle(
                                    color: AppColor.kLightTextColor,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough
                                )
                            ),
                            Text(
                                'BDT 111',
                                style: TextStyle(
                                    color: AppColor.kMainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: -4,
                    right: 2,
                    child: MaterialButton(
                      onPressed: () {},
                      splashColor: AppColor.kMainColor,
                      color: AppColor.kMainColor.withOpacity(0.4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ADD',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColor.kMainColor, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Icon(Icons.add_sharp, size: 15, color: AppColor.kMainColor)
                        ],
                      ),
                      elevation: 0,
                      height: 28,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    ).paddingOnly(bottom: 8);
  }
}