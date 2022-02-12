import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JioSaavnWrapper Example App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searching = false;
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: searching ? Colors.white : null,
        title: !searching
            ? Text('Awesome Music')
            : CupertinoSearchTextField(
                onChanged: (searchQuery) {
                  setState(() => this.searchQuery = searchQuery.toLowerCase());
                },
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() => searching = !searching);
              },
              icon: Icon(
                searching ? Icons.cancel_outlined : Icons.search,
                color: searching ? Colors.black : null,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: searching
            ? searchQuery.isEmpty
                ? Center(
                    child: Text(
                      'Search Something e.g. song name or artist name...',
                    ),
                  )
                : _buildSearchList()
            : _buildTopSongs(),
      ),
    );
  }

  FutureBuilder<SearchResult> _buildSearchList() {
    return FutureBuilder<SearchResult>(
      future:
          JioSaavnWrapper.instance.fetchSearchResults(searchQuery: searchQuery),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.songs.length,
            itemBuilder: (context, index) => ListTile(
              leading: SizedBox(
                height: 48,
                width: 48,
                child: CachedNetworkImage(
                  imageUrl: snapshot.data!.songs[index].image,
                ),
              ),
              title: Text(snapshot.data!.songs[index].title),
              subtitle: Text(
                snapshot.data!.songs[index].description,
                maxLines: 2,
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('No results Found....'),
            );
          } else {
            return Center(
              child: Text('Search Something Like song name or artist name...'),
            );
          }
        }
      },
    );
  }

  FutureBuilder<Playlist?> _buildTopSongs() {
    return FutureBuilder<Playlist?>(
        future: JioSaavnWrapper.instance.fetchTopSongs(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.songs.length ?? 0,
                itemBuilder: (context, index) => Card(
                  elevation: 10,
                  child: ListTile(
                    title: Text(
                      snapshot.data!.songs[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      snapshot.data!.songs[index].subtitle,
                      maxLines: 2,
                    ),
                    leading: SizedBox(
                      height: 48,
                      width: 48,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.songs[index].mediumResImage,
                        ),
                      ),
                    ),
                    trailing: Icon(Icons.play_arrow_outlined),
                  ),
                ),
              )
            : snapshot.hasError
                ? Center(
                    child: SelectableText(
                    snapshot.error.toString(),
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
