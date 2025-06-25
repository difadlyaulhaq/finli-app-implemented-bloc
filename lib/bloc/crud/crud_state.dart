

import 'package:finli_app/bloc/crud/crud_model.dart';

class CrudState {}

final class CrudInitial extends CrudState {}

final class CrudUploading extends CrudState {}

final class CrudUploaded extends CrudState {}

final class CrudUploadError extends CrudState {
  final String error;
  CrudUploadError(this.error);
}

final class FetchLoading extends CrudState {}

final class FetchLoaded extends CrudState {
  final List<TransactionModel> transactions;
  FetchLoaded({required this.transactions});
}

final class FetchError extends CrudState {
  final String error;
  FetchError(this.error);
}