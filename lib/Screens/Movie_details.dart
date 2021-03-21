import 'package:flutter/material.dart';
import 'package:venflix/Models/moviemodel.dart';
import 'package:venflix/Models/trending_Model.dart';
import 'package:venflix/Networking/Services.dart';
import 'package:venflix/Networking/getImage.dart';

import 'package:venflix/components/constants.dart';

class MovieDetail extends StatefulWidget {
  //PASSING DATA FROM MOVIE SCREEN TO DETAIL SCREEN
  final String snapshotImage;
  final String snapshotMovieName;
  final num snapshotRating;
  final int id;

  const MovieDetail(
      {Key key,
      @required this.snapshotImage,
      @required this.snapshotRating,
      @required this.snapshotMovieName,
      @required this.id})
      : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Future<MovieModel> movieModel;

  Api _api;

  @override
  void initState() {
    _api = Api();
    movieModel = _api.getMovieInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<MovieModel>(
          future: movieModel,
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
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
                          height: MediaQuery.of(context).size.height * 0.75),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      //                  RichText(
                                      //   text: TextSpan(
                                      //     children: List.generate(
                                      //       snapshot.data.genre.length,
                                      //       (i) {
                                      //         return TextSpan(
                                      //             text:
                                      //                 "${snapshot.data.genre[i]['name']} ");
                                      //       },
                                      //     ),
                                      //     style: Theme.of(context).textTheme.caption,
                                      //   ),
                                      // ),

                                      Text(
                                        "${snapshot.data.popularity}",
                                        style: kVoteAverage,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 25),
                                          child: Column(
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
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.green,
                                        child: Text("86"),
                                        padding: EdgeInsets.all(5),
                                      ),
                                      Text(
                                        "Metascore",
                                        style: kmetaScoreText,
                                      ),
                                      Text(
                                        "${snapshot.data.vote_count} critic reviews",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    margin: EdgeInsets.only(right: 20),
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
                                child: Text(
                                    "${DateTime.parse(snapshot.data.release_date).year}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text("PG13"),
                              ),
                              Text("${getDuration(snapshot.data.run_time)}"),
                            ],
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 2; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ChoiceChip(
                                    label: Text(
                                        "${snapshot.data.genre[i]['name']}"),
                                    selected: false,
                                  ),
                                )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Plot Summary",
                              style: plotSummaryText,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              child: Text(
                                "${snapshot.data.overview}",
                                style: kOverviewText,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
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
