import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

// import '../pageObjectModel/homePage.dart';

class CheckHomePage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String val1) async {
    // HomePage homePage = HomePage(world.driver);
    // homePage.addNote();
    final button = find.byValueKey(val1);
    await FlutterDriverUtils.isPresent(button, world.driver);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string} button on homepage");
}

class ClickAddNotes extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async{
    final button = find.byValueKey(input1);
    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
  
}

class GotoAddNotePage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async{

    final addNotesPage = find.byValueKey(input1);
    await FlutterDriverUtils.isPresent(addNotesPage, world.driver);
  }

  @override
  RegExp get pattern => RegExp(r'I should have {String} on screen');
}