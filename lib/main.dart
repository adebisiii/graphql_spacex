import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_spacex/config/client.dart';

import 'screens/HomeScreen.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: CacheProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                color: Colors.black87,
              )),
            ),
            home: HomeScreen()),
      ),
    );
  }
}
