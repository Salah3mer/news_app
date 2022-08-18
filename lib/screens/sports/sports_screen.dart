
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_cubit/cubit.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/share/Components/components.dart';

class Sport_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        builder: (context,state){
          List<dynamic> list= NewsCubit.get(context).sport;
          return BuildNewesScreen(list: list,scroll: false);
        },
        listener: (context,state){}
    );
  }
}
