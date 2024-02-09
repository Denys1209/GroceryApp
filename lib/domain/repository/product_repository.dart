import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:bloc_project_test/domain/entities/product_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final String productCollectionName = 'ProductCollection';

  Future<List<ProductDataModel>> getAllProducts() async {
    final CollectionReference collectionRef =
        _firestore.collection(productCollectionName);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<ProductDataModel> products = List.empty(growable: true);
    allData.map((e) =>
        products.add(ProductDataModel.fromMap(e as Map<String, dynamic>)));

    return products;
  }

  Future<String> _uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childName).child(auth.currentUser!.uid);

    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> createProduct(
    String name,
    String description,
    double price,
    Uint8List file,
  ) async {
    String res = "some error occurred";

    try {
      String id = const Uuid().v1();
      String image = await _uploadImageToStorage(id, file);

      ProductDataModel model = ProductDataModel(
        id: id,
        name: name,
        description: description,
        price: price,
        imageUrl: image,
      );
      _firestore
          .collection(productCollectionName)
          .doc(model.id)
          .set(model.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
