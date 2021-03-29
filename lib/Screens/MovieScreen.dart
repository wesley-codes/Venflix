import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:venflix/Models/trending_Model.dart';
import 'package:venflix/Networking/getImage.dart';
import 'package:venflix/Screens/Movie_details.dart';
import 'package:venflix/components/choice_chip.dart';
import 'package:venflix/components/constants.dart';
import 'package:venflix/Networking/Services.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // CONVETING POPULAR MOVIES TO LIST
  Future<List<PopularMoviesModel>> popularMovies;

  Api _api;

  @override
  void initState() {
    super.initState();
    _api = Api();
    popularMovies = _api.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Icon(
              Icons.search,
              color: Colors.black,
            )
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.format_indent_increase,
                color: Colors.black,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          bottom: TabBar(
            tabs: [
              TabBarText(
                title: "In Theater",
              ),
              TabBarText(
                title: "Box Office",
              ),
              TabBarText(
                title: "Comedy",
              ),
            ],
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(),
            indicatorPadding: EdgeInsets.only(bottom: 20),
          ),
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    children: [
                      ChoiceChips(
                        title: "Action",
                      ),
                      ChoiceChips(
                        title: "Crime",
                      ),
                      ChoiceChips(
                        title: "Comedy",
                      ),
                      ChoiceChips(
                        title: "Drama",
                      ),
                      ChoiceChips(
                        title: "Sci-fi",
                      ),
                      ChoiceChips(
                        title: "Adventure",
                      ),
                      ChoiceChips(
                        title: "Horror",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<PopularMoviesModel>>(
              future: popularMovies,
              // ignore: missing_return
              builder:
                  // ignore: missing_return
                  (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 550,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int id) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: AspectRatio(
                            aspectRatio: 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                            snapshotImage: getImagePoster(
                                                snapshot.data[id].poster_path),
                                            snapshotMovieName: snapshot
                                                .data[id].original_title,
                                            snapshotRating:
                                                snapshot.data[id].vote_average,
                                            id: snapshot.data[id].id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 25),
                                    width:
                                        MediaQuery.maybeOf(context).size.width /
                                            1.7,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(
                                        getImagePoster(
                                            snapshot.data[id].poster_path),
// ignore: missing_return
                                        loadingBuilder:
                                            // ignore: missing_return
                                            (BuildContext context,
                                                child,
                                                ImageChunkEvent
                                                    loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },

                                        errorBuilder:
                                            // ignore: non_constant_identifier_names
                                            (context, error, StackTrace) =>
                                                Text("An error occurred!"),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.grey[400],
                                            offset: Offset(0, 3))
                                      ],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 5),
                                  child: Text(
                                    snapshot.data[id].original_title,
                                    style: kMovieTitleName,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffFCC419),
                                    ),
                                    Text(
                                      "${snapshot.data[id].vote_average}",
                                      style: kVoteAverage,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarText extends StatelessWidget {
  final String title;
  const TabBarText({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: kTabBarViewText,
      ),
    );
  }
}
