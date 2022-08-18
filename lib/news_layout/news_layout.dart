import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:news_app/news_cubit/cubit.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/screens/search/search.dart';

class News_Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [

              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> Search_screen()));
              },
                  icon: Icon(Icons.search,size: 30,)),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 15),
                child: IconButton(
                  icon: c.isDark
                      ? Icon(FontAwesomeIcons.solidSun,
                          color: Colors.deepOrange, size: 35)
                      : Icon(
                          FontAwesomeIcons.cloudMoon,
                          color: HexColor('1e2336'),
                          size: 35,
                        ),
                  onPressed: () {
                    c.changeMood();
                  },
                ),
              )


            ],
          ),
          body: c.screens[c.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: c.bottomItem,
            currentIndex: c.currentIndex,
            onTap: (index) {
              c.bottomNavChange(index);
            },
          ),
        );
      },
    );
  }
}
