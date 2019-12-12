import 'package:flutter_driver/flutter_driver.dart';
import '../lib/logics/logics.dart';
import 'package:test/test.dart';

void main(){
  group('Note App', (){
    final addNoteButton = find.byValueKey('addNotes');
    final saveButton = find.byValueKey('saveButton');
    // final titleField = find.byValueKey('titleField');
    // final noteField = find.byValueKey('noteField');
    // final index3 = find.byValueKey('2');

    FlutterDriver driver;

    setUpAll(()async{
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async{
      if(driver != null){
        driver.close();
      }
    });

    test("Click addNote button", ()async{
      await driver.tap(addNoteButton);

      expect(await driver.getText(saveButton), 'Add Notes');
    });

    test("Check for empty Notes", (){
      var result = Logics.validateFormFields("");
      expect(result, 'This field can\'t be empty');
    });
  });
}