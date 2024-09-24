
import 'package:app2/detailpage.dart';
import 'package:app2/splash.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix-like App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.red, fontSize: 35, fontWeight: FontWeight.w500),
        ),
      ),
      //home: const MainScreen(),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(66, 168, 161, 161),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _shows = [];
  List<dynamic> _featuredShows = [];

  @override
  void initState() {
    super.initState();
    _fetchShows();
  }

  Future<void> _fetchShows() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        _shows = json.decode(response.body).map((show) => show['show']).toList();
        _featuredShows = _shows.take(5).toList();
      });
    } else {
      throw Exception('Failed to load shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Netflix'),
       
    //   ),
    //   body: _shows.isEmpty
    //       ? Center(child: CircularProgressIndicator())
    //       : 
          
    //       Column(
    //           children: [
    //             // Text('Featured shows' , style: TextStyle(color : Colors.white , fontWeight: FontWeight.w500),),
    //             CarouselSlider(
    //               options: CarouselOptions(
    //                 autoPlay: true,
    //                 enlargeCenterPage: true,
    //                 aspectRatio: 2.0,
    //                 onPageChanged: (index, reason) {},
    //               ),
    //               items: _featuredShows.map((show) {
    //                 return Builder(
    //                   builder: (BuildContext context) {
    //                     return Container(
    //                       margin: EdgeInsets.symmetric(horizontal: 5.0),
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(10),
    //                         image: DecorationImage(
    //                           image: NetworkImage(show['image']?['medium'] ?? ''),
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 );
    //               }).toList(),
    //             ),
    //             SizedBox(height: 30),
    //            //Text('Top 10 in India today' , style: TextStyle(color : Colors.white , fontWeight: FontWeight.w500 , fontSize: 25),),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16.0), 
    //               child: Text(
    //                 'Top 10 in India today',
    //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
    //               ),
    //             ),
               
    //             Expanded(
    //               child:GridView.builder(
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 3,
    //             childAspectRatio: 0.7,
    //           ),
    //           itemCount: _shows.length,
    //           itemBuilder: (context, index) {
    //             final show = _shows[index];
    //             return  Card(
    //           child: Column(
    //             children: [
    //               Container(child: 
    //                 Expanded(child:  Image.network(
    //                     show['image']?['medium'] ?? '',
    //                     fit: BoxFit.cover,
    //                   ),)
    //                 ),
                  
    //               // Text(
    //               //   show['name'],
    //               //   style: TextStyle(fontWeight: FontWeight.bold),
    //               // ),
    //             ],
    //           ),
    //         );
               
    //           },
    //         ),
    //         ),]),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Netflix'),
      ),
      body: _shows.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(  // Wrap the entire layout in SingleChildScrollView
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                    ),
                    items: _featuredShows.map((show) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(show['image']?['medium'] ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 200, // Set a height for the carousel
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                    child: Text(
                      'Top 10 in India today',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20), // Add some space between the text and the grid
                  Container( // Wrap GridView in a Container with a defined height
                    height: 500, // Adjust height as needed
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling in GridView
                      shrinkWrap: true, // Allow GridView to take the height of its content
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _shows.length,
                      itemBuilder: (context, index) {
                        final show = _shows[index];
                        return GestureDetector(
                          onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
                             title: show['name'],
        imageUrl: show['image']?['medium'] ?? '',
        summary: show['summary'] ?? 'No summary available',
                          )));},
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  show['image']?['medium'] ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
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

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchShows(String query) async {
    if (query.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body).map((show) => show['show']).toList();
        });
      } else {
        throw Exception('Failed to search shows');
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color : Colors.white),
              decoration: InputDecoration(
                hintText: 'Search shows...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchShows(_searchController.text);
                  },
                ),
                border: OutlineInputBorder(),
              ),
              onSubmitted: _searchShows,
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(child: Text('No results found', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final show = _searchResults[index];
                      return 
                      
                    Padding(padding : EdgeInsets.only(bottom: 40) ,
                    child:   ListTile(
                        leading: Image.network(show['image']?['medium'] ?? '', width: 50),
                        title: Text(show['name'], style: TextStyle(color: Colors.white)),
                       // subtitle: Text(show['summary'] ?? 'No summary available', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          // Navigate to show details if needed
                        },
                      ));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
