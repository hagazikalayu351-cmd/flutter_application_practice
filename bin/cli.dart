import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('please provide a valid command argument');
  } else if (arguments.first == 'version') {
    print('your cli is a version of $version');
  } else if (arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'search') {
    // Add this new block:
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs: inputArgs);
  } else {
    print('invalid command argument');
  }
}

void printUsage() {
  print("the following commands are valid: 'help','version' ");
}

void searchWikipedia({List<String>? inputArgs}) {
  final String articleTitle;
  if (inputArgs == null || inputArgs.isEmpty) {
    print('please provide a valid search command');
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    articleTitle = inputArgs.join(' ');
  }
  print('Searching Wikipedia for: $articleTitle');
}
