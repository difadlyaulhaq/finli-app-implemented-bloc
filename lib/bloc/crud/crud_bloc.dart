import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finli_app/bloc/crud/crud_model.dart';
import 'package:finli_app/bloc/crud/crud_event.dart';
import 'package:finli_app/bloc/crud/crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final FirebaseFirestore firestore;
  
  CrudBloc({
    required this.firestore
  }) : super(CrudInitial()) {
    
    // Handle upload event
    on<CrudUploadEvent>((event, emit) async {
      emit(CrudUploading());
      try {
        await firestore.collection('transactions').add(event.transaction.toMap());
        emit(CrudUploaded());
      } catch (e) {
        emit(CrudUploadError(e.toString()));
      }
    });
    
    // Handle fetch transactions event
    on<FetchTransactionsEvent>((event, emit) async {
      emit(FetchLoading());
      try {
        final snapshot = await firestore
            .collection('transactions')
            .orderBy('timestamp', descending: true) // Order by timestamp if you have it
            .get();
        
        final transactions = snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList();
            
        emit(FetchLoaded(transactions: transactions));
      } catch (e) {
        emit(FetchError(e.toString()));
      }
    });
  }
}