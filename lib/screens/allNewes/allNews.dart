import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_cubit/cubit.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/screens/webview/webview.dart';
import 'package:news_app/share/Components/components.dart';

class All_Newes_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          List<dynamic> list = NewsCubit.get(context).everything;
          return ConditionalBuilder(
            condition: list.length > 0,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CarouselSlider.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index, s) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Webview_Screen(
                                            list[index]['url'])));
                              },
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      width: 1000,
                                      imageUrl: list[index]['urlToImage'],
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.black.withOpacity(0.4),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${list[index]['title']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 18,
                                                  color: Colors.deepOrange,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '${list[index]['publishedAt']}',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        options: CarouselOptions(
                            autoPlay: true,
                            //  size
                            aspectRatio: 2,
                            enlargeCenterPage: true)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      'Recent News',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BuildNewesScreen(list: list, scroll: true),
                ],
              ),
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: Colors.deepOrange,
            )),
          );
        },
        listener: (context, state) {});
  }
}
