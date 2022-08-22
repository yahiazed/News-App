// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/widgets/listtile.dart';

import 'package:newsapp/features/newsfeatures/presentation/cubit/app_cubit.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_states.dart';

import '../../../../core/Network/networkinfo.dart';

class BusinessSC extends StatelessWidget {
  const BusinessSC({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ErrorBusinessNews) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 50,
            width: double.infinity,
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: Text('Some Thing Wrong '),
          )));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (state is ErrorBusinessNews) {
          return Container(
            child: Center(
              child: Text('No Internet Connection'),
            ),
          );
        } else {
          return Container(
            child: ConditionalBuilder(
              condition: cubit.businessList.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                    itemBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 200,
                        child: ListItem(news: cubit.businessList[index])),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                    itemCount: cubit.businessList.length);
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
