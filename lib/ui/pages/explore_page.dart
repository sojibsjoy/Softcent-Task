import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:softcent_test/state_management/controllers/products_controller.dart';
import 'package:softcent_test/state_management/models/products_model.dart';
import 'package:softcent_test/ui/designs/custom_inpt_field.dart';
import 'package:softcent_test/ui/designs/dialog_design.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ProductsController _productsCon = Get.find<ProductsController>();
  final TextEditingController _searchCon = TextEditingController();
  final FocusNode _searchNode = FocusNode();

  int _divisionPeriod = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _divisionPeriod = 0;
          _productsCon.getProducts();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.h,
                  right: 20.h,
                  bottom: 30.h,
                ),
                child: CustomInptField(
                  textCon: _searchCon,
                  labelText: "Search in Swipexyz",
                  focusNode: _searchNode,
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade100,
              ),
              SizedBox(height: 16.h),
              Obx(() {
                if (_productsCon.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                  );
                } else {
                  if (_productsCon.products.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 300.h),
                      child: Center(
                        child: Text(
                          "No Data Found!",
                          style: TextStyle(
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _productsCon.products.length % 9 == 0
                          ? (_productsCon.products.length / 9).floor()
                          : (_productsCon.products.length / 9).floor() + 1,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (_productsCon.products.length - _divisionPeriod >=
                            9) {
                          var temp1 = _divisionPeriod;
                          var temp2 = _divisionPeriod + 9;
                          _divisionPeriod = _divisionPeriod + 9;
                          return _buildSubList(
                            _productsCon.products.sublist(temp1, temp2),
                          );
                        } else {
                          return _buildSubList(
                            _productsCon.products.sublist(_divisionPeriod),
                          );
                        }
                      },
                    );
                  }
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubList(List<Products> tempString) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: StaggeredGrid.count(
        crossAxisCount: 15,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: tempString.mapIndexed((i, e) {
          if (i == 3) {
            return StaggeredGridTile.count(
              crossAxisCellCount: 9,
              mainAxisCellCount: 10,
              child: _buildListItem(item: e),
            );
          } else if (i == 4 || i == 5) {
            return StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 5,
              child: _buildListItem(item: e),
            );
          } else {
            return StaggeredGridTile.count(
              crossAxisCellCount: 5,
              mainAxisCellCount: 5,
              child: _buildListItem(item: e),
            );
          }
        }).toList(),
      ),
    );
  }

  Widget _buildListItem({
    required Products item,
  }) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
            ),
            content: DialogDesign(products: item),
          );
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.network(
            item.thumbnail,
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
        ),
      ),
    );
  }
  /*AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );*/
}
