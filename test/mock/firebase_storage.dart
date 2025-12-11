import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseStorage>(),
  MockSpec<Reference>(),
  MockSpec<TaskSnapshot>(),
  MockSpec<UploadTask>()
])
void main() {}