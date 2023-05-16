import 'dart:async';
import 'package:flutter/material.dart';

import '../models/tvshow.dart';
import '../network/request_data.dart';
import 'detail_screen.dart';

class ShowListing extends StatefulWidget {
  const ShowListing() : super();

  @override
  _ShowListingState createState() => _ShowListingState();
}

class DelayAction {
  Timer? _timer;

  void execute(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _ShowListingState extends State<ShowListing> {
  final _delayAction = DelayAction();
  List<TvShows>? _showList = [];
  List<TvShows>? _filteredShowList = [];

  @override
  void initState() {
    super.initState();
    fetchdata().then((showsFromServer) {
      setState(() {
        _showList = showsFromServer.cast<TvShows>();
        _filteredShowList = _showList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 35, top: 50),
              padding: const EdgeInsets.only(bottom: 5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(15.0),
                  hintText: 'Search Shows',
                  hintStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onChanged: (string) {
                  _delayAction.execute(() {
                    setState(() {
                      _filteredShowList = _showList!
                          .where(
                            (show) => (show.name!.toLowerCase().contains(string.toLowerCase())),
                      )
                          .toList();
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.5),
                ),
                itemCount: _filteredShowList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(id: _filteredShowList![index].id)
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage('${_filteredShowList![index].imageThumbnailPath}'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
