import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/detail.dart';
import '../models/tvshow.dart';

const String url = 'https://www.episodate.com/api/search?q=arrow&page=1';

Future<List<TvShows>> fetchdata() async {
  final response =
      await http.get(Uri.parse('https://www.episodate.com/api/most-popular'));

  Map data = jsonDecode(response.body);
  List templist = data['tv_shows'].map((i) => i).toList();

  //print(data);
  return TvShows.movieSnapshot(templist);
}

Future<Detail> fetchDetailFilm(int id) async {
  String url = "https://www.episodate.com/api/show-details?q=$id";
  try {
    final response = await http.get(Uri.parse(url));
    final extractedData = convert.jsonDecode(response.body);
    final filmData = extractedData["tvShow"];
    return Detail.fromJson(filmData);
  } catch (error) {
    rethrow;
  }
}

