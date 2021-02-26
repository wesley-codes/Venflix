import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:venflix/Networking/GenreModel.dart';
import 'package:venflix/Networking/getImage.dart';
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
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              width: 250,
                              child: Image(
                                image: NetworkImage(
                                  getImagePoster(
                                      snapshot.data[index].poster_path),
                                ),
                                fit: BoxFit.contain,
                              ),
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

class ChoiceChips extends StatelessWidget {
  final String title;

  const ChoiceChips({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ChoiceChip(
        label: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
          child: Text(
            title,
            style: kChoiceChipsText,
          ),
        ),
        selected: false,
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
