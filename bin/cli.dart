import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'wikipedia') {
    // Changed to 'wikipedia'
    // Pass all arguments *after* 'wikipedia' to searchWikipedia
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(
      inputArgs,
    ); // Call searchWikipedia (no 'await' needed here for main)
  } else {
    printUsage(); // Catch all for any unrecognized command.
  }
}

void searchWikipedia(List<String>? arguments) async {
  // Added 'async'
  final String articleTitle;

  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    // Read input and provide a default empty string if the input is null.
    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return;
    }
    articleTitle = inputFromStdin;
  } else {
    // Otherwise, join the arguments into a single string.
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait.');
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

void printUsage() {
  print(
    "the following commands are valid: 'help','version', 'search', 'wikipedia'",
  );
}

Future<String> getWikipediaArticle(String articleTitle) async {
  /*in this case the future is used to indicate that the function will return a 
   string in the future but not immediatly because it is an asynchronous operation.
   and the async keyword marks the function as asynchronous allowing to use await inside it*/
  final url = Uri.https(
    //this constructs the API url
    'en.wikipedia.org', //english wikipedia domain
    '/api/rest_v1/page/summary/$articleTitle', //part of the url that specifies the endpoint for fetching a summary of a specific article
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
