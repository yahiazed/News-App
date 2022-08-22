import 'package:equatable/equatable.dart';

class News extends Equatable {
  final int id;
  String? image;
  String? title;
  String? date;
  String? author;
  String? description;
  String? url;
  News({
    required this.id,
    this.image,
    this.title,
    this.date,
    this.author,
    this.description,
    this.url,
  });

  @override
  List<Object?> get props => [author, description, image, title, date, url];
}
