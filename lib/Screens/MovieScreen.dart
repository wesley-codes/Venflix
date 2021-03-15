import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
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
      length: 10,
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
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
              Tab(
                text: "nnoij",
              ),
            ],
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(),
            indicatorPadding: EdgeInsets.only(bottom: 20),
          ),
        ),
        body: Column(
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
            Expanded(
              child: FutureBuilder<List<PopularMoviesModel>>(
                future: popularMovies,
                // ignore: missing_return
                builder:
                    // ignore: missing_return
                    (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: AspectRatio(
                            aspectRatio: 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MovieDetail(
                                              snapshotImage: getImagePoster(
                                                  snapshot
                                                      .data[index].poster_path),
                                              snapshotMovieName: snapshot
                                                  .data[index].original_title,
                                              snapshotRating: snapshot
                                                  .data[index].vote_average,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 25),
                                        width: MediaQuery.maybeOf(context)
                                                .size
                                                .width /
                                            1.7,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Image.network(
                                            getImagePoster(snapshot
                                                .data[index].poster_path),
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
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            // ignore: non_constant_identifier_names
                                            errorBuilder:
                                                (context, error, StackTrace) =>
                                                    Text("An error occurred!"),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),

                                              // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 5),
                                  child: Text(
                                    snapshot.data[index].original_title,
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
                                      "${snapshot.data[index].vote_average}",
                                      style: kVoteAverage,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
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
