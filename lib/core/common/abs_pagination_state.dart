// ignore_for_file: unnecessary_this

import 'package:ecom_app/core/constants/enum.dart';
import 'abs_normal_state.dart';
import 'failure_state.dart';

abstract class AbsPaginationState<T> extends AbsNormalState<T> {
  final int currentPage, lastPage, totalRecord;

  const AbsPaginationState({
    super.failure,
    super.data,
    required super.absNormalStatus,
    required this.currentPage,
    required this.lastPage,
    required this.totalRecord,
  });

  @override
  AbsPaginationState<T> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
    int? currentPage,
    lastPage,
    totalNo,
  });
}

class AbsPaginationStateImpl<T> extends AbsPaginationState<T>
    with MxAbsPaginationState<T> {
  AbsPaginationStateImpl({
    super.failure,
    super.data,
    required super.absNormalStatus,
    required super.currentPage,
    required super.lastPage,
    required super.totalRecord,
  });

  @override
  AbsPaginationState<T> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
    int? currentPage,
    lastPage,
    totalNo,
  }) {
    return AbsPaginationStateImpl<T>(
      data: data ?? this.data,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalRecord: totalNo ?? this.totalRecord,
    );
  }

  @override
  List<Object?> get props => [
    data,
    failure,
    absNormalStatus,
    currentPage,
    lastPage,
    totalRecord,
  ];
}

class AbsPaginationInitialState<T> extends AbsPaginationStateImpl<T> {
  AbsPaginationInitialState()
    : super(
        absNormalStatus: AbsNormalStatus.INITIAL,
        currentPage: 1,
        lastPage: 1,
        totalRecord: 0,
      );
}

mixin MxAbsPaginationState<T> {
  AbsPaginationStateImpl<T> initialState(T data) {
    return AbsPaginationStateImpl<T>(
      absNormalStatus: AbsNormalStatus.INITIAL,
      totalRecord: 0,
      lastPage: 1,
      currentPage: 1,
      data: data,
    );
  }

  AbsPaginationStateImpl<T> refreshState(T data) {
    return AbsPaginationStateImpl<T>(
      absNormalStatus: AbsNormalStatus.LOADING,
      totalRecord: 0,
      lastPage: 1,
      currentPage: 1,
      data: data,
    );
  }
}
