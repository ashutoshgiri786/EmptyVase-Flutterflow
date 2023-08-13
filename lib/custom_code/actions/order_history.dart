// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:graphql_flutter/graphql_flutter.dart';

Future<dynamic> orderHistory(
  String customerAccessToken,
) async {
  final httpLink = HttpLink(
    FFAppState().graphqlEndpoint,
    defaultHeaders: {
      'X-Shopify-Storefront-Access-Token': FFAppState().storefrontAccessToken,
    },
  );

  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  final String query = '''
    query FetchCustomerInfo(\$customerAccessToken: String!) {
      customer(customerAccessToken: \$customerAccessToken) {
        orders(first: 10) {
          edges {
            node {
              id
              orderNumber
              processedAt
              financialStatus
              fulfillmentStatus
            }
          }
        }
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(query),
    variables: {
      "customerAccessToken": customerAccessToken,
    },
  );

  final QueryResult result = await client.query(options);

  if (result.hasException) {
    print('Error: ${result.exception.toString()}');
    return null;
  }

  return result.data?["customer"]["orders"]["edges"];
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
