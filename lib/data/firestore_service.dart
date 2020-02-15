import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:sampleproject/data/model/note.dart';


class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._internal();
  
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService(){
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db
    .collection('notes')
    .snapshots()
    .map((snapshot) => snapshot.documents.map((e) => Note.fromMap(e.data, e.documentID),
      ).toList(),
    );
  }

}