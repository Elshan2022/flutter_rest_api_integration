import 'package:flutter/material.dart';
import 'package:flutter_rest_api_provider/model/post_model.dart';
import 'package:flutter_rest_api_provider/service/post_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const appTitle = "Post List";
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => IPostService()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: FutureBuilder<List<PostModel>>(
          future: context.watch<IPostService>().fetchPostItem(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              var userList = snapshot.data!;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userList[index].title.toString()),
                      subtitle: Text(userList[index].body.toString()),
                      leading: CircleAvatar(
                        child: Text(
                          userList[index].id.toString(),
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Data not found"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
