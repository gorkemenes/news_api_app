import 'package:flutter/material.dart';
import 'package:news_app/utils/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "NEWS",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiServices.getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Image.network(
                                snapshot.data![index].urlToImage ?? ''),
                            ListTile(
                              title: Text(
                                snapshot.data![index].title.toString(),
                              ),
                              subtitle:
                                  Text(snapshot.data![index].author.toString()),
                            ),
                            ButtonBar(
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(
                                        snapshot.data![index].url ?? ''));
                                  },
                                  child: const Text(
                                    "Habere git",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("{$snapshot.error}");
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
