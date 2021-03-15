import 'package:flutter/material.dart';
import 'package:venflix/Models/trending_Model.dart';
import 'package:venflix/Networking/Services.dart';

import 'package:venflix/components/constants.dart';

class MovieDetail extends StatefulWidget {
  //PASSING DATA FROM MOVIE SCREEN TO DETAIL SCREEN
  final String snapshotImage;
  final String snapshotMovieName;
  final num snapshotRating;

  const MovieDetail(
      {Key key,
      @required this.snapshotImage,
      @required this.snapshotRating,
      @required this.snapshotMovieName})
      : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Future<List<PopularMoviesModel>> popularMovies;

  Api _api;

  @override
  void initState() {
    super.initState();
    _api = Api();
    popularMovies = _api.fetchPopularMovies();
    print(popularMovies);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<PopularMoviesModel>>(
          future: popularMovies,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      widget.snapshotImage,
                                    ),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.75),
                          Positioned(
                            top: 20,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black87,
                                ),
                                onPressed: () {}),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 26,
                            child: Transform.translate(
                              offset: Offset(0, 80 / 2),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 30,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${widget.snapshotRating}",
                                                style: kNumerator,
                                              ),
                                              Text(
                                                "/10",
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${snapshot.data[index].popularity}",
                                            style: kVoteAverage,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.star_border_outlined,
                                              size: 30,
                                            ),
                                          ),
                                          Text(
                                            "Rate This",
                                            style: kRateThis,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.green,
                                            child: Text("86"),
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Text(
                                            "Metascore",
                                            style: kRateThis,
                                          ),
                                          Text(
                                            "${snapshot.data[index].vote_count} critic reviews",
                                            style: kCriticReviews,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: Colors.grey.withOpacity(0.9),
                                        offset: Offset(
                                          10.0,
                                          10.0,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          margin: EdgeInsets.only(left: 35),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${widget.snapshotMovieName}",
                                      style: kMovieNameDetail,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFE6D8E),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text("2019"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text("PG13"),
                                  ),
                                  Text("2hrs 32mins"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
