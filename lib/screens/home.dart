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
        title: const Text(
          "News App",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 63, 79),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
