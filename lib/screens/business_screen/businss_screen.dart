
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_cubit/cubit.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/share/Components/components.dart';

class Business_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<NewsCubit,NewsStates>(
        builder: (context,state){
          List<dynamic> list= NewsCubit.get(context).business;
          return ConditionalBuilder(
              condition: list.length >0  ,
              builder: (context)=> BuildNewesScreen(list: list,scroll: false),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),);
        },
        listener: (context,state){}
    );

  }
}
