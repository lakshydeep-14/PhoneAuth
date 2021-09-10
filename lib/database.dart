import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneList{

  static FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  static Future<DocumentReference> addphoneList(String item){
    CollectionReference _itemReference = _firebaseFirestore.collection("PhoneList");
    var data={
      'phn':item,
    };
    print("done");
    return _itemReference.add(data);
  }
  

}