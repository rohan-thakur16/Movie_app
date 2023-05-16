import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_api/screens/search_screen.dart';

import '../models/tvshow.dart';
import '../network/request_data.dart';
import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TvShows>? tvShows;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    tvShows = await fetchdata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.black,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/sm_icon.png',fit: BoxFit.cover),
            Container(
                padding: const EdgeInsets.only(left: 78.0), child: const Text('Screen Media'))
          ],

        ),
      ),
    ),
      body: Container(
      color: Colors.black38,  // Changed the color here
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Container(
        margin: const EdgeInsets.only(top: 60, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowListing()),
            );
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: InkWell(
              child: const Icon(Icons.search),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowListing()),
                );
              },
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: 'Search ...',
          ),
        ),
    ),
    Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(5),
    height: 40,
    child: const Text(
    'Most Popular Tv Shows',
    style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    ),
    //Most Popular
    Container(
    height: 310,
    padding: const EdgeInsets.all(10),
    child: FutureBuilder(
    future: fetchdata(),
    builder: (context, snapShot) {
    if (snapShot.hasData) {
    return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: MediaQuery.of(context).size.width /
    (MediaQuery.of(context).size.height / 1.6),
    ), itemCount: tvShows == null ? 0 : tvShows!.length,
    itemBuilder: (BuildContext context, int index) {
    TvShows tvShow = tvShows![index];
    return InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => DetailPage(
    id: tvShows![index].id,
    )));
    },
    child: Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(
    Radius.circular(20)),
    boxShadow: const [
    ],
    image: DecorationImage(
    image: NetworkImage(
          '${tvShows![index].imageThumbnailPath}'),
          fit: BoxFit.cover)),
        //  child: Text('${userLists![index].name}'),
    ),
    );
    },
    );
    } else if (snapShot.hasError) {
        return const Text('Failed');
    } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
    },
    ),
    ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(5),
                height: 40,
                child: const Text(
                  'Top 10 Tv Shows',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              //Top 10 Tv Shows
              SizedBox(
                height: 220,
                child: FutureBuilder(
                  future: fetchdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: 1.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tvShows == null
                                  ? 0
                                  : (tvShows!.length > 10 ? 10 : tvShows!.length),
                              itemBuilder: (BuildContext context, int index) {
                                TvShows tvShow = tvShows![index];
                                return InkWell(
                                    onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        id: tvShows![index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 190,
                                width: 125,
                                decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                                ),
                                boxShadow: const [
                                BoxShadow(),
                                ],
                                image: DecorationImage(
                                image: NetworkImage('${tvShows![index].imageThumbnailPath}'),
                                fit: BoxFit.cover,
                                // child: Text('${tvShows![index].name}'),
                                ),
                                ),
                                ));
                              }));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
        ),
      ),
      ),
      ),
    );
  }
}
