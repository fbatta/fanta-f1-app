import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<File>(),
  MockSpec<FileStat>()
])
void main() {}