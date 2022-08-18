import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_cubit/cubit.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/share/Components/components.dart';

class Search_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var search;
          List<dynamic> list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded)),
              title: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
                onSaved: (value){
                  search=value;
                },
                onChanged: (String value) {
                  NewsCubit.get(context).getSearch(value);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end:15.0),
                  child: IconButton(onPressed: (){

                  }, icon: Icon(Icons.search,size: 30,)),
                )
              ],
            ),
            body:  BuildNewesScreen(list: list, scroll: false),
          );
        },
        listener: (context, state) {});
  }
}
