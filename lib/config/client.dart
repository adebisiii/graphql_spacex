import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final HttpLink httpLink = HttpLink('https://api.spacex.land/graphql/');

  static ValueNotifier<GraphQLClient> initailizeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    ));
    return client;
  }
}
