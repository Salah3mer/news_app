
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/network/local/cash_helper.dart';

import 'bloc_observer.dart';
import 'news_cubit/cubit.dart';
import 'news_cubit/states.dart';
import 'news_layout/news_layout.dart';

void main() async{

  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  await Cash_Helper.init();
  DioHelper.init();

  bool isDark=Cash_Helper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return BlocProvider(
        create: (BuildContext context) =>NewsCubit()..changeMood(shareMood: isDark)..getBusinessData()..getSciencesData()..getSportsData()..getEverything(),
       child:BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var c = NewsCubit.get(context);
          return  MaterialApp (

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              backgroundColor: Colors.grey[100],
              textTheme:TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ) ,
              primarySwatch: Colors.deepOrange,

              scaffoldBackgroundColor: Colors.white,

              appBarTheme: AppBarTheme(
                actionsIconTheme:IconThemeData(

                    color: Colors.black
                ),

                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,

                ),
                titleTextStyle: TextStyle(

                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,


                ),


              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(

                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                elevation: 0,
                type: BottomNavigationBarType.fixed,

              ),
            ),
            darkTheme: ThemeData(
              backgroundColor: HexColor('1e2336'),
              textTheme:TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ) ,
              primarySwatch: Colors.deepOrange,

              scaffoldBackgroundColor:HexColor('0e121a') ,

              appBarTheme: AppBarTheme(

                backgroundColor: HexColor('0e121a'),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('0e121a'),
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,

                ),
                titleTextStyle: TextStyle(

                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,


                ),


              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(

                  backgroundColor: HexColor('0e121a'),
                  selectedItemColor: Colors.deepOrange,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.grey

              ),
            ),
            themeMode: c.isDark ? ThemeMode.dark:ThemeMode.light,
            home: News_Layout(),
          );
    }

      )

    );


  }
}
