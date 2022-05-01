import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
      child: Container(
        // height: 400,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
           color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 20,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 45,
                                    height: 45,

                                  )),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                              
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: MediaQuery.of(context).size.width*0.4,
                                  height: 20,
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: MediaQuery.of(context).size.width*0.3,
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark)))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),

// Divider(height: 10,),
          ],
        ),
      ),
    );
  }
}
