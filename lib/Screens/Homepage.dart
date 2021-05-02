import 'package:flutter/material.dart';
import 'package:search_bar_app/Repository/SearchItems.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Demo"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: StudentSearch());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class StudentSearch extends SearchDelegate<Students> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? studentDetails
        : studentDetails
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 40,
                        ),
                        title: Text(listItems[index].name),
                        subtitle: Text(
                            "Roll No : ${(listItems[index].id.toString())}"),
                        onTap: () {
                          showResults(context);
                        },
                      ),
                      Divider(),
                    ],
                  ));
            });
  }
}
