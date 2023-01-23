import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

final mAuth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance;
final firrstore = FirebaseFirestore.instance;
final usercol = FirebaseFirestore.instance.collection('users');
final postcol = FirebaseFirestore.instance.collection('posts');

final logs = Logger();