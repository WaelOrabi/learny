import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Post {
  final int id;
  final String title;
  final String body;
  Post(this.title, this.body,this.id);

}
class PostItem extends StatelessWidget {

  final String title;
  final String body;
  final int id;

  const PostItem(this.title, this.body,this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [

                Text('$id  $title',
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
            const SizedBox(height: 10,),
            Text(body,
              style: const TextStyle(
                  fontSize: 15
              ),)
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home:  const InfiniteScrollPaginatorDemo(),
    );
  }
}


class InfiniteScrollPaginatorDemo extends StatefulWidget {
  const InfiniteScrollPaginatorDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InfiniteScrollPaginatorDemoState createState() => _InfiniteScrollPaginatorDemoState();
}

class _InfiniteScrollPaginatorDemoState extends State<InfiniteScrollPaginatorDemo> {
  final _numberOfPostsPerRequest = 10;

  final PagingController<int, Post> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$_numberOfPostsPerRequest"));
      List responseList = json.decode(response.body);
      List<Post> postList = responseList.map((data) =>
          Post(data['title'], data['body'],data['id'])).toList();
      final isLastPage = postList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(postList, nextPageKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error --> $e");
      }
      _pagingController.error = e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Blog App"), centerTitle: true,),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, Post>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (context, item, index) =>
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: PostItem(
                      item.title, item.body,item.id
                  ),
                ),

          ),

        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:dio/dio.dart';
//
// // Define a model class for the data you want to fetch and display
// class Post {
//   final int id;
//   final String title;
//   final String body;
//
//   Post({required this.id, required this.title, required this.body});
//
//   // Parse a Post object from a JSON map
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
//
// // Define a Dio client to make API requests
// final dio = Dio();
//
// // Define a function to fetch a page of data from the API
// // The API endpoint is https://jsonplaceholder.typicode.com/posts
// // The API returns a list of 100 posts, each with an id, title, and body
// // The function takes a page number as a parameter and returns a list of posts
// Future<List<Post>> fetchPosts(int page) async {
//   // Calculate the start and end indices for the page
//   // Assume each page has 10 items
//   final start = (page - 1) * 10;
//   final end = start + 10;
//
//   // Make a GET request to the API with the _start and _end query parameters
//   final response = await dio.get(
//     'https://jsonplaceholder.typicode.com/posts',
//     queryParameters: {
//       '_start': start,
//       '_end': end,
//     },
//   );
//
//   // Check the status code and throw an exception if it is not 200
//   if (response.statusCode == 200) {
//     // Parse the response data as a list of JSON maps
//     final data = response.data as List;
//
//     // Map each JSON map to a Post object and return the list
//     return data.map((json) => Post.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load posts');
//   }
// }
//
// // Define a global key for the paging controller
// final pagingController = PagingController<int, Post>(
//   // Set the first page key to 1
//   firstPageKey: 1,
// );
//
// // Define a stateful widget for the app
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// // Define the app state
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     // Add a listener to the paging controller
//     pagingController.addPageRequestListener((pageKey) {
//       // Call the fetchPosts function with the pageKey and append the result to the paging controller
//       fetchPosts(pageKey).then((posts) {
//         // Check if the posts list is empty or less than the page size
//         // If yes, set the last page to the pageKey
//         // If no, set the next page key to the pageKey + 1
//         if (posts.isEmpty || posts.length < 10) {
//           pagingController.appendLastPage(posts);
//         } else {
//           pagingController.appendPage(posts, pageKey + 1);
//         }
//       }).catchError((error) {
//         // Handle the error and append it to the paging controller
//         pagingController.error = error;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // Dispose the paging controller when the widget is disposed
//     pagingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Return a MaterialApp widget with a Scaffold
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Infinite Scroll Pagination Example'),
//         ),
//         body: PagedListView<int, Post>(
//           // Set the paging controller for the PagedListView
//           pagingController: pagingController,
//           // Set the builder delegate for the PagedListView
//           builderDelegate: PagedChildBuilderDelegate<Post>(
//             // Set the itemBuilder for the PagedChildBuilderDelegate
//             itemBuilder: (context, post, index) {
//               // Return a ListTile widget for each post
//               return ListTile(
//                 leading: Text(post.id.toString()),
//                 title: Text(post.title),
//                 subtitle: Text(post.body),
//               );
//             },
//             // Set the firstPageErrorIndicatorBuilder for the PagedChildBuilderDelegate
//             firstPageErrorIndicatorBuilder: (context) {
//               // Return a Center widget with a Column
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Display an icon and a text for the error
//                     Icon(Icons.error, color: Colors.red, size: 64),
//                     Text('Something went wrong'),
//                     // Display a button to retry the request
//                     TextButton(
//                       onPressed: () => pagingController.refresh(),
//                       child: Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             // Set the newPageErrorIndicatorBuilder for the PagedChildBuilderDelegate
//             newPageErrorIndicatorBuilder: (context) {
//               // Return a Center widget with a TextButton
//               return Center(
//                 child: TextButton(
//                   onPressed: () => pagingController.retryLastFailedRequest(),
//                   child: Text('Retry'),
//                 ),
//               );
//             },
//             // Set the noItemsFoundIndicatorBuilder for the PagedChildBuilderDelegate
//             noItemsFoundIndicatorBuilder: (context) {
//               // Return a Center widget with a Text
//               return Center(
//                 child: Text('No items found'),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
