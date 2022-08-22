// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/widgets/listtile.dart';

import '../cubit/app_cubit.dart';
import '../cubit/app_states.dart';

class ScienceSC extends StatelessWidget {
  const ScienceSC({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (state is ErrorScienceNews) {
          return Container(
            child: Center(
              child: Text('No Internet Connection'),
            ),
          );
        } else {
          return Container(
            child: ConditionalBuilder(
              condition: cubit.scienceList.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                    itemBuilder: (context, index) =>
                        ListItem(news: cubit.scienceList[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 2,
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
