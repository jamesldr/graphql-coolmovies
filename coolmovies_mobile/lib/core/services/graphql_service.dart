import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';

export 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  static Future<GraphQLClient> get client async {
    await initHiveForFlutter();

    final HttpLink httpLink = HttpLink(
      Platform.isAndroid
          ? 'http://10.0.2.2:5001/graphql'
          : 'http://localhost:5001/graphql',
    );
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );

    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
      alwaysRebroadcast: true,
    );
  }
}
