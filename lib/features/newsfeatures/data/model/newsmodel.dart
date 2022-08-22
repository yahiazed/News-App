import 'package:flutter/cupertino.dart';
import 'package:newsapp/features/newsfeatures/domain/entites/news.dart';

// class NewsArticles {
//   List<NewsModel> listNews=[];
//   factory NewsArticles.fromJson(Map<String,dynamic>json){
//     json['articles'].
//   }

// }

class NewsModel extends News {
  NewsModel(
      {super.image,
      super.title,
      super.date,
      super.author,
      super.description,
      super.url})
      : super(id: 0);
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      image: json['urlToImage'] ??
          'https://img.freepik.com/premium-vector/process-smartphone-application-update_18660-3698.jpg?w=740',
      title: json['title'] ?? 'loading',
      date: json['publishedAt'] ?? 'loading',
      author: json['author'] ?? 'Unknown',
      description: json['description'] ?? 'loading',
      url: json['url'] ?? 'loading',
    );
  }
  Map<String, dynamic> tojson() {
    return {
      'urlToImage': image,
      'title': title,
      'publishedAt': date,
      'author': author,
      'description': description,
      'url': url,
    };
  }
}
