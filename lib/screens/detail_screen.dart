import 'package:flutter/material.dart';
import 'package:movie_api/models/detail.dart';

import '../db/DatabaseHelper.dart';
import '../models/post.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  int id;
  DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Detail> detailFilm;
  late Post post;

  @override
  void initState() {
    super.initState();
    detailFilm = fetchDetailFilm(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder<Detail>(
        future: detailFilm,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final detailData = snapshot.data!; // Access the data from the snapshot

            return Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  color: const Color(0xff21242C),
                ),
                SizedBox(
                  height: size.height * .6,
                  width: size.width,
                  child: Hero(
                    tag: '',
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${detailData.image}'),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Color(0xff21242C),
                              Color(0xff21242C).withOpacity(.8),
                              Color(0xff21242C).withOpacity(.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 510,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      SizedBox(
                        height: 40,
                        child: Text(
                          detailData.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      //network and day
                      Row(
                        children: [
                          Text(
                            detailData.network,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            detailData.startDate,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            detailData.description,
                            style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          savePost();
        },
        child: Icon(Icons.save),
      ),
    );
  }
  void savePost() async {
    final detailSnapshot = await detailFilm;
    final detailData = detailSnapshot; // Update this line according to your Detail class structure

    if (detailData != null) {
      final post = Post(
        id: detailData.id,
        title: detailData.name,
        content: detailData.description,
        createdAt: DateTime.now(),
      );

      await DatabaseHelper.instance.savePost(post);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post saved successfully!')),
      );
    }
  }

}
