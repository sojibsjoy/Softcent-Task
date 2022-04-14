import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softcent_test/ui/pages/explore_page.dart';
import 'package:softcent_test/ui/pages/home_page.dart';
import 'package:softcent_test/ui/pages/inbox_page.dart';
import 'package:softcent_test/ui/pages/shop_page.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: _buildScreens(),
      bottomNavigationBar: Container(
        height: 100.h,
        color: Colors.white,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              index: 0,
              icon: 'assets/svg/Home.svg',
              title: "Home",
            ),
            _buildNavItem(
              index: 1,
              icon: 'assets/svg/Explore.svg',
              title: "Explore",
            ),
            _buildNavItem(
              index: 2,
              icon: 'assets/svg/Add.svg',
              title: "Add",
            ),
            _buildNavItem(
              index: 3,
              icon: 'assets/svg/Inbox.svg',
              title: "Inbox",
            ),
            _buildNavItem(
              index: 4,
              icon: 'assets/svg/Shop.svg',
              title: "Shop",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreens() {
    switch (_pageIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ExplorePage();
      case 2:
        return const ExplorePage();
      case 3:
        return const InboxPage();
      case 4:
        return const ShopPage();
      default:
        return const ExplorePage();
    }
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String title,
  }) {
    return InkWell(
      onTap: () => setState(() => _pageIndex = index),
      child: Container(
        padding: EdgeInsets.only(top: index != 2 ? 15.h : 0),
        height: 60.h,
        width: 60.h,
        child: Column(
          children: [
            index != 2
                ? SvgPicture.asset(
                    icon,
                    height: 25.h,
                    color:
                        _pageIndex == index ? Colors.deepOrange : Colors.grey,
                    fit: BoxFit.contain,
                  )
                : Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
            SizedBox(height: 3.h),
            if (index != 2)
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: _pageIndex == index ? Colors.deepOrange : Colors.grey,
                ),
                child: Text(
                  title,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
