// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:graphql_flutter/graphql_flutter.dart';

Future<dynamic> search(
  String query,
) async {
  final httpLink = HttpLink(
    FFAppState().graphqlEndpoint,
    defaultHeaders: {
      'X-Shopify-Storefront-Access-Token': FFAppState().storefrontAccessToken,
    },
  );

  final client = GraphQLClient(link: httpLink, cache: GraphQLCache());

  final String mutation = '''
{
    
  products(first: 5, query: "(title:$query*) OR (inventory_total:>0)" ) {
    edges {
      node {
        	collections(first: 50) {
      edges {
            channelNode : node {
          channelTitle :title
        }
      }
    }
        id
        title
        createdAt
        totalInventory
        images(first:1){

            edges{
                imageNode:node{
                    url
                }
            }
        }
      }
    }
  }}


''';

  final MutationOptions options = MutationOptions(document: gql(mutation));

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    print('Error: ${result.exception.toString()}');
    return null;
  }

  return result.data;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
