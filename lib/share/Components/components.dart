import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/webview/webview.dart';

Widget BuildNewesScreen({@required list, bool scroll,}) =>
    ListView.builder(
      padding: const EdgeInsets.all(15.0),
      shrinkWrap: scroll,

      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index,) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Webview_Screen(list[index]['url'])));
        },
        child: Container(
          margin: const EdgeInsetsDirectional.only(bottom: 15),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: list[index]['urlToImage'],
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 3,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.deepOrange,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(15),
                      topStart: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${list[index]['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.deepOrange,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              list[index]['publishedAt'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          )
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
      itemCount: list.length,
// separatorBuilder: (context,index)=> Padding(padding:EdgeInsetsDirectional.)
    );
