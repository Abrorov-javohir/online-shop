import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uy_ishi_3/model/product.dart';

class QuizFirebaseService {
  final CollectionReference quizCollection = FirebaseFirestore.instance.collection('quiz');

  // Stream to get the list of quizzes
  Stream<QuerySnapshot> get quizzes => quizCollection.snapshots();

  // Function to add a new quiz
  Future<void> addQuiz(Product quiz) {
    return quizCollection.add(quiz.toJson());
  }

  // Function to delete a quiz by id
  Future<void> deleteQuiz(String id) {
    return quizCollection.doc(id).delete();
  }
}