import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTime {
  final rootRef = FirebaseDatabase.instance.ref();

  Future<dynamic> saveToDb(String path, dynamic data) async {
    await rootRef.child(path).set(data);
  }

  Future<dynamic> getFromDB(String path) async {
    rootRef.child(path).once().then((value) {
      // print("Value:............");
      // print(path);
      // print(value.snapshot.value);
      return value.snapshot.value;
    });
  }
}
