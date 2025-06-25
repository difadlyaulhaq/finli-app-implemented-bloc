import 'package:finli_app/bloc/crud/crud_model.dart';

class CrudEvent {}

final class CrudUploadEvent extends CrudEvent {
  final TransactionModel transaction;
  CrudUploadEvent(this.transaction);
}

final class FetchTransactionsEvent extends CrudEvent {}

final class UpdateTransactionsEvent extends CrudEvent {
  final String docid;
  final TransactionModel transaction;
  UpdateTransactionsEvent(this.docid, this.transaction);
}
