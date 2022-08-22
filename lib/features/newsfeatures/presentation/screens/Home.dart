// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/shared/app_localization.dart';
import 'package:newsapp/core/style/icon_broken.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_cubit.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_states.dart';

class HomeSC extends StatelessWidget {
  const HomeSC({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.bottomIndex].tr(context),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeTheme();
                    print('jhhhhhh${cubit.isDark}');
                  },
                  icon: Icon(
                    Icons.brightness_medium_outlined,
                    color: Colors.white,
                  ))
            ],
          ),
          body: cubit.Screens[cubit.bottomIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomIndex,
              onTap: (int value) {
                cubit.changeBottomIndex(value);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Work,
                  ),
                  label: "Business".tr(context),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports,
                  ),
                  label: "Sports".tr(context),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.science,
                  ),
                  label: "Science".tr(context),
                ),
              ]),
        );
      },
    );
  }
}
