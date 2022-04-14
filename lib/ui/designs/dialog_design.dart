import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:softcent_test/state_management/models/products_model.dart';

class DialogDesign extends StatefulWidget {
  final Products products;
  const DialogDesign({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<DialogDesign> createState() => _DialogDesignState();
}

class _DialogDesignState extends State<DialogDesign> {
  final PageController _pageCon = PageController(
    initialPage: 0,
  );
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 386.h,
      width: 250.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
              child: Row(
                children: [
                  // User Image
                  Container(
                    height: 32.h,
                    width: 32.h,
                    margin: EdgeInsets.only(right: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        widget.products.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // User name and location
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.products.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.products.brand,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // follow button
                  InkWell(
                    onTap: () {
                      // TODO: add logic to follow someone
                    },
                    child: Container(
                      height: 32.h,
                      width: 94.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.deepOrange.withOpacity(
                          0.1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/Follow.svg",
                            height: 20.h,
                            fit: BoxFit.fitHeight,
                            color: Colors.deepOrange,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 234.h,
              width: 234.h,
              margin: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: _pageCon,
                    onPageChanged: (page) => setState(() => index = page),
                    scrollDirection: Axis.horizontal,
                    children: widget.products.images
                        .map((e) => _buildPageViewPage(e))
                        .toList(),
                  ),
                  _buildIndicator(),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View Post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade200,
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(234.w, 44.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageViewPage(String imgLink) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: Image.network(
        imgLink,
        fit: BoxFit.cover,
        errorBuilder: ((context, error, stackTrace) {
          return Icon(
            Icons.image,
            size: 30.h,
            color: Colors.grey,
          );
        }),
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                    value: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                        : null,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: index,
        count: widget.products.images.length,
        effect: ExpandingDotsEffect(
          dotColor: Colors.grey.shade500,
          activeDotColor: Colors.deepOrange,
          dotHeight: 5.h,
          dotWidth: 5.w,
        ),
      );
}
