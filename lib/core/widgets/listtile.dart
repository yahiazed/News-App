// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/Network/networkinfo.dart';
import 'package:newsapp/features/newsfeatures/domain/entites/news.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_cubit.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_states.dart';
import 'package:newsapp/features/newsfeatures/presentation/screens/detailsscreen.dart';

class ListItem extends StatelessWidget {
  News news;

  ListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsSC(
                    url: news.url ?? 'www.google.com',
                  ),
                ));
          },
          child: Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: news.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Spacer(),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title ?? 'load',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  news.author ?? 'Unknown',
                                  style: TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  news.date ?? 'sorry',
                                  style: TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
