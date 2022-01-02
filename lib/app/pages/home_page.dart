import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:sbazar/app/pages/farm_page.dart';
import 'package:sbazar/others/resources/colors.dart';
import 'package:sbazar/others/resources/fonts.dart';
import 'package:sbazar/others/resources/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: (){},
            icon: Icon(
                Icons.menu
            ),
          ),
          title: MaterialButton(
            onPressed: () async{

            },
            splashColor: AppColor.WHITE,
            color: AppColor.WHITE,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'user_selected_current_location',
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.BLACK,
                      fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.BLACK,
                  size: 20,
                )
              ],
            ),
            elevation: 0,
            padding: const EdgeInsets.all(0),
            minWidth: 0,
            height: 20,
            materialTapTargetSize:
            MaterialTapTargetSize.shrinkWrap,
            focusColor: AppColor.GREEN.withOpacity(0.8),
          ),
          actions: [
            CartButton()
          ],
        ),
        body: CustomScrollView(
          slivers: [

            _SearchBox(),

            // _HomeScreenSearchResultView(),

            _PopularFarms(),

            _AllRestaurants(),
          ],
          reverse: false
        )
    );
  }
}

class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        decoration: BoxDecoration(
            color: AppColor.WHITE,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey.shade200,
                width: 1
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(-1, -1),
                  blurRadius: 5),
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(1, 1),
                  blurRadius: 5)
            ]),
        child: TextFormField(
          cursorColor: AppColor.GREEN,
          onChanged: (value){

          },
          autofocus: false,
          style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColor.BLACK, fontSize: 18),
          decoration: InputDecoration(
              hintText: 'Search on S-Bazar',
              hintStyle: Theme.of(context).textTheme.subtitle2,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              prefixIcon: Icon(
                Icons.search,
                color: AppColor.GREEN,
              ),
              focusColor: AppColor.BLACK,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        ),
      )
    );
  }
}

class _StickyHeader extends StatelessWidget {
  final String header;
  const _StickyHeader({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Text(
        header,
        style: TextStyle(
          fontFamily: CFontFamily.BOLD,
          fontSize: 22
        ),
      ),
    );
  }
}

class _PopularFarms extends StatelessWidget {
  const _PopularFarms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _StickyHeader(header: 'Popular Farms'),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: Get.height * .32,
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 12),
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) => FarmCard(/*data: HomeViewModel.popularStores[index]*/)
          ),
        ),
      ),
    );
  }
}

class _AllRestaurants extends StatelessWidget {
  const _AllRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SliverStickyHeader(
      header: _StickyHeader(header: 'All Farms'),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => FarmCard(/*data: HomeViewModel.allStore[index], */vertical: true),
          childCount: 20,
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  final Color? color;
  const CartButton({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: AppColor.GREEN,
          ),
        ),
        // Positioned(
        //   right: 4,
        //   child: Container(
        //     child: Text(
        //       CartViewModel.cartItems.length.toString(),
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 12,
        //           color: color == null ? Colors.white : Colors.black
        //       ),
        //     ),
        //     decoration: BoxDecoration(
        //         color: color ?? AppColor.kMainColor,
        //         shape: BoxShape.circle
        //     ),
        //     padding: EdgeInsets.all(4),
        //   ),
        // )
      ],
    );
  }
}

class FarmCard extends StatelessWidget {
  // final StoreModel data;
  final bool vertical;
  const FarmCard({Key? key,
    // required this.data,
    this.vertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>FarmPage());
      },
      child: Container(
        width: vertical ? double.infinity : Get.width * .7,
        margin: EdgeInsets.only(top: 2,bottom: vertical ? 20 : 2,right: vertical ? 12 : 8, left: vertical ? 12 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider('https://images.unsplash.com/photo-1534723452862-4c874018d66d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c3RvcmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                              fit: BoxFit.cover
                          )
                      ),
                    )
                )
              ],
            ),

            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'data.storeName'.trim().capitalize!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Strings.TAKA_SIGN+Strings.TAKA_SIGN,
                        style: TextStyle(
                          color: AppColor.kLightTextColor
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.circle,
                          color: AppColor.kLightTextColor,
                          size: 4,
                        ),
                      ),

                      Wrap(
                        children: List.generate(4, (index) => Text(
                          'tag ,',
                          style: TextStyle(
                              color: AppColor.kLightTextColor
                          ),
                        )),
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_bike,
                        color: AppColor.kLightTextColor,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Tk 14',
                        style: TextStyle(
                          // color: AppColor.kL
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}