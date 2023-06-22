// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmployeeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EmployeeM data) upsertEmployee,
    required TResult Function() getEmployees,
    required TResult Function(EmployeeM data) deleteEmployee,
    required TResult Function() undoDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EmployeeM data)? upsertEmployee,
    TResult? Function()? getEmployees,
    TResult? Function(EmployeeM data)? deleteEmployee,
    TResult? Function()? undoDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EmployeeM data)? upsertEmployee,
    TResult Function()? getEmployees,
    TResult Function(EmployeeM data)? deleteEmployee,
    TResult Function()? undoDelete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpsertEmployee value) upsertEmployee,
    required TResult Function(GetEmployees value) getEmployees,
    required TResult Function(DeleteEmployee value) deleteEmployee,
    required TResult Function(UndoDelete value) undoDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpsertEmployee value)? upsertEmployee,
    TResult? Function(GetEmployees value)? getEmployees,
    TResult? Function(DeleteEmployee value)? deleteEmployee,
    TResult? Function(UndoDelete value)? undoDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpsertEmployee value)? upsertEmployee,
    TResult Function(GetEmployees value)? getEmployees,
    TResult Function(DeleteEmployee value)? deleteEmployee,
    TResult Function(UndoDelete value)? undoDelete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeEventCopyWith<$Res> {
  factory $EmployeeEventCopyWith(
          EmployeeEvent value, $Res Function(EmployeeEvent) then) =
      _$EmployeeEventCopyWithImpl<$Res, EmployeeEvent>;
}

/// @nodoc
class _$EmployeeEventCopyWithImpl<$Res, $Val extends EmployeeEvent>
    implements $EmployeeEventCopyWith<$Res> {
  _$EmployeeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UpsertEmployeeCopyWith<$Res> {
  factory _$$UpsertEmployeeCopyWith(
          _$UpsertEmployee value, $Res Function(_$UpsertEmployee) then) =
      __$$UpsertEmployeeCopyWithImpl<$Res>;
  @useResult
  $Res call({EmployeeM data});
}

/// @nodoc
class __$$UpsertEmployeeCopyWithImpl<$Res>
    extends _$EmployeeEventCopyWithImpl<$Res, _$UpsertEmployee>
    implements _$$UpsertEmployeeCopyWith<$Res> {
  __$$UpsertEmployeeCopyWithImpl(
      _$UpsertEmployee _value, $Res Function(_$UpsertEmployee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$UpsertEmployee(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EmployeeM,
    ));
  }
}

/// @nodoc

class _$UpsertEmployee implements UpsertEmployee {
  const _$UpsertEmployee({required this.data});

  @override
  final EmployeeM data;

  @override
  String toString() {
    return 'EmployeeEvent.upsertEmployee(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpsertEmployee &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpsertEmployeeCopyWith<_$UpsertEmployee> get copyWith =>
      __$$UpsertEmployeeCopyWithImpl<_$UpsertEmployee>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EmployeeM data) upsertEmployee,
    required TResult Function() getEmployees,
    required TResult Function(EmployeeM data) deleteEmployee,
    required TResult Function() undoDelete,
  }) {
    return upsertEmployee(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EmployeeM data)? upsertEmployee,
    TResult? Function()? getEmployees,
    TResult? Function(EmployeeM data)? deleteEmployee,
    TResult? Function()? undoDelete,
  }) {
    return upsertEmployee?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EmployeeM data)? upsertEmployee,
    TResult Function()? getEmployees,
    TResult Function(EmployeeM data)? deleteEmployee,
    TResult Function()? undoDelete,
    required TResult orElse(),
  }) {
    if (upsertEmployee != null) {
      return upsertEmployee(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpsertEmployee value) upsertEmployee,
    required TResult Function(GetEmployees value) getEmployees,
    required TResult Function(DeleteEmployee value) deleteEmployee,
    required TResult Function(UndoDelete value) undoDelete,
  }) {
    return upsertEmployee(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpsertEmployee value)? upsertEmployee,
    TResult? Function(GetEmployees value)? getEmployees,
    TResult? Function(DeleteEmployee value)? deleteEmployee,
    TResult? Function(UndoDelete value)? undoDelete,
  }) {
    return upsertEmployee?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpsertEmployee value)? upsertEmployee,
    TResult Function(GetEmployees value)? getEmployees,
    TResult Function(DeleteEmployee value)? deleteEmployee,
    TResult Function(UndoDelete value)? undoDelete,
    required TResult orElse(),
  }) {
    if (upsertEmployee != null) {
      return upsertEmployee(this);
    }
    return orElse();
  }
}

abstract class UpsertEmployee implements EmployeeEvent {
  const factory UpsertEmployee({required final EmployeeM data}) =
      _$UpsertEmployee;

  EmployeeM get data;
  @JsonKey(ignore: true)
  _$$UpsertEmployeeCopyWith<_$UpsertEmployee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetEmployeesCopyWith<$Res> {
  factory _$$GetEmployeesCopyWith(
          _$GetEmployees value, $Res Function(_$GetEmployees) then) =
      __$$GetEmployeesCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetEmployeesCopyWithImpl<$Res>
    extends _$EmployeeEventCopyWithImpl<$Res, _$GetEmployees>
    implements _$$GetEmployeesCopyWith<$Res> {
  __$$GetEmployeesCopyWithImpl(
      _$GetEmployees _value, $Res Function(_$GetEmployees) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetEmployees implements GetEmployees {
  const _$GetEmployees();

  @override
  String toString() {
    return 'EmployeeEvent.getEmployees()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetEmployees);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EmployeeM data) upsertEmployee,
    required TResult Function() getEmployees,
    required TResult Function(EmployeeM data) deleteEmployee,
    required TResult Function() undoDelete,
  }) {
    return getEmployees();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EmployeeM data)? upsertEmployee,
    TResult? Function()? getEmployees,
    TResult? Function(EmployeeM data)? deleteEmployee,
    TResult? Function()? undoDelete,
  }) {
    return getEmployees?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EmployeeM data)? upsertEmployee,
    TResult Function()? getEmployees,
    TResult Function(EmployeeM data)? deleteEmployee,
    TResult Function()? undoDelete,
    required TResult orElse(),
  }) {
    if (getEmployees != null) {
      return getEmployees();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpsertEmployee value) upsertEmployee,
    required TResult Function(GetEmployees value) getEmployees,
    required TResult Function(DeleteEmployee value) deleteEmployee,
    required TResult Function(UndoDelete value) undoDelete,
  }) {
    return getEmployees(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpsertEmployee value)? upsertEmployee,
    TResult? Function(GetEmployees value)? getEmployees,
    TResult? Function(DeleteEmployee value)? deleteEmployee,
    TResult? Function(UndoDelete value)? undoDelete,
  }) {
    return getEmployees?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpsertEmployee value)? upsertEmployee,
    TResult Function(GetEmployees value)? getEmployees,
    TResult Function(DeleteEmployee value)? deleteEmployee,
    TResult Function(UndoDelete value)? undoDelete,
    required TResult orElse(),
  }) {
    if (getEmployees != null) {
      return getEmployees(this);
    }
    return orElse();
  }
}

abstract class GetEmployees implements EmployeeEvent {
  const factory GetEmployees() = _$GetEmployees;
}

/// @nodoc
abstract class _$$DeleteEmployeeCopyWith<$Res> {
  factory _$$DeleteEmployeeCopyWith(
          _$DeleteEmployee value, $Res Function(_$DeleteEmployee) then) =
      __$$DeleteEmployeeCopyWithImpl<$Res>;
  @useResult
  $Res call({EmployeeM data});
}

/// @nodoc
class __$$DeleteEmployeeCopyWithImpl<$Res>
    extends _$EmployeeEventCopyWithImpl<$Res, _$DeleteEmployee>
    implements _$$DeleteEmployeeCopyWith<$Res> {
  __$$DeleteEmployeeCopyWithImpl(
      _$DeleteEmployee _value, $Res Function(_$DeleteEmployee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$DeleteEmployee(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EmployeeM,
    ));
  }
}

/// @nodoc

class _$DeleteEmployee implements DeleteEmployee {
  const _$DeleteEmployee({required this.data});

  @override
  final EmployeeM data;

  @override
  String toString() {
    return 'EmployeeEvent.deleteEmployee(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteEmployee &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteEmployeeCopyWith<_$DeleteEmployee> get copyWith =>
      __$$DeleteEmployeeCopyWithImpl<_$DeleteEmployee>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EmployeeM data) upsertEmployee,
    required TResult Function() getEmployees,
    required TResult Function(EmployeeM data) deleteEmployee,
    required TResult Function() undoDelete,
  }) {
    return deleteEmployee(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EmployeeM data)? upsertEmployee,
    TResult? Function()? getEmployees,
    TResult? Function(EmployeeM data)? deleteEmployee,
    TResult? Function()? undoDelete,
  }) {
    return deleteEmployee?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EmployeeM data)? upsertEmployee,
    TResult Function()? getEmployees,
    TResult Function(EmployeeM data)? deleteEmployee,
    TResult Function()? undoDelete,
    required TResult orElse(),
  }) {
    if (deleteEmployee != null) {
      return deleteEmployee(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpsertEmployee value) upsertEmployee,
    required TResult Function(GetEmployees value) getEmployees,
    required TResult Function(DeleteEmployee value) deleteEmployee,
    required TResult Function(UndoDelete value) undoDelete,
  }) {
    return deleteEmployee(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpsertEmployee value)? upsertEmployee,
    TResult? Function(GetEmployees value)? getEmployees,
    TResult? Function(DeleteEmployee value)? deleteEmployee,
    TResult? Function(UndoDelete value)? undoDelete,
  }) {
    return deleteEmployee?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpsertEmployee value)? upsertEmployee,
    TResult Function(GetEmployees value)? getEmployees,
    TResult Function(DeleteEmployee value)? deleteEmployee,
    TResult Function(UndoDelete value)? undoDelete,
    required TResult orElse(),
  }) {
    if (deleteEmployee != null) {
      return deleteEmployee(this);
    }
    return orElse();
  }
}

abstract class DeleteEmployee implements EmployeeEvent {
  const factory DeleteEmployee({required final EmployeeM data}) =
      _$DeleteEmployee;

  EmployeeM get data;
  @JsonKey(ignore: true)
  _$$DeleteEmployeeCopyWith<_$DeleteEmployee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndoDeleteCopyWith<$Res> {
  factory _$$UndoDeleteCopyWith(
          _$UndoDelete value, $Res Function(_$UndoDelete) then) =
      __$$UndoDeleteCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndoDeleteCopyWithImpl<$Res>
    extends _$EmployeeEventCopyWithImpl<$Res, _$UndoDelete>
    implements _$$UndoDeleteCopyWith<$Res> {
  __$$UndoDeleteCopyWithImpl(
      _$UndoDelete _value, $Res Function(_$UndoDelete) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UndoDelete implements UndoDelete {
  const _$UndoDelete();

  @override
  String toString() {
    return 'EmployeeEvent.undoDelete()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UndoDelete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EmployeeM data) upsertEmployee,
    required TResult Function() getEmployees,
    required TResult Function(EmployeeM data) deleteEmployee,
    required TResult Function() undoDelete,
  }) {
    return undoDelete();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EmployeeM data)? upsertEmployee,
    TResult? Function()? getEmployees,
    TResult? Function(EmployeeM data)? deleteEmployee,
    TResult? Function()? undoDelete,
  }) {
    return undoDelete?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EmployeeM data)? upsertEmployee,
    TResult Function()? getEmployees,
    TResult Function(EmployeeM data)? deleteEmployee,
    TResult Function()? undoDelete,
    required TResult orElse(),
  }) {
    if (undoDelete != null) {
      return undoDelete();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpsertEmployee value) upsertEmployee,
    required TResult Function(GetEmployees value) getEmployees,
    required TResult Function(DeleteEmployee value) deleteEmployee,
    required TResult Function(UndoDelete value) undoDelete,
  }) {
    return undoDelete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpsertEmployee value)? upsertEmployee,
    TResult? Function(GetEmployees value)? getEmployees,
    TResult? Function(DeleteEmployee value)? deleteEmployee,
    TResult? Function(UndoDelete value)? undoDelete,
  }) {
    return undoDelete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpsertEmployee value)? upsertEmployee,
    TResult Function(GetEmployees value)? getEmployees,
    TResult Function(DeleteEmployee value)? deleteEmployee,
    TResult Function(UndoDelete value)? undoDelete,
    required TResult orElse(),
  }) {
    if (undoDelete != null) {
      return undoDelete(this);
    }
    return orElse();
  }
}

abstract class UndoDelete implements EmployeeEvent {
  const factory UndoDelete() = _$UndoDelete;
}

/// @nodoc
mixin _$EmployeeState {
  List<EmployeeM> get currentEmployees => throw _privateConstructorUsedError;
  List<EmployeeM> get previousEmployees => throw _privateConstructorUsedError;
  EmployeeStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  EmployeeM? get lastDeleteData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmployeeStateCopyWith<EmployeeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeStateCopyWith<$Res> {
  factory $EmployeeStateCopyWith(
          EmployeeState value, $Res Function(EmployeeState) then) =
      _$EmployeeStateCopyWithImpl<$Res, EmployeeState>;
  @useResult
  $Res call(
      {List<EmployeeM> currentEmployees,
      List<EmployeeM> previousEmployees,
      EmployeeStatus status,
      String errorMessage,
      EmployeeM? lastDeleteData});

  $EmployeeStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$EmployeeStateCopyWithImpl<$Res, $Val extends EmployeeState>
    implements $EmployeeStateCopyWith<$Res> {
  _$EmployeeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEmployees = null,
    Object? previousEmployees = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? lastDeleteData = freezed,
  }) {
    return _then(_value.copyWith(
      currentEmployees: null == currentEmployees
          ? _value.currentEmployees
          : currentEmployees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeM>,
      previousEmployees: null == previousEmployees
          ? _value.previousEmployees
          : previousEmployees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeM>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeStatus,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastDeleteData: freezed == lastDeleteData
          ? _value.lastDeleteData
          : lastDeleteData // ignore: cast_nullable_to_non_nullable
              as EmployeeM?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EmployeeStatusCopyWith<$Res> get status {
    return $EmployeeStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EmployeeStateCopyWith<$Res>
    implements $EmployeeStateCopyWith<$Res> {
  factory _$$_EmployeeStateCopyWith(
          _$_EmployeeState value, $Res Function(_$_EmployeeState) then) =
      __$$_EmployeeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EmployeeM> currentEmployees,
      List<EmployeeM> previousEmployees,
      EmployeeStatus status,
      String errorMessage,
      EmployeeM? lastDeleteData});

  @override
  $EmployeeStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$_EmployeeStateCopyWithImpl<$Res>
    extends _$EmployeeStateCopyWithImpl<$Res, _$_EmployeeState>
    implements _$$_EmployeeStateCopyWith<$Res> {
  __$$_EmployeeStateCopyWithImpl(
      _$_EmployeeState _value, $Res Function(_$_EmployeeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEmployees = null,
    Object? previousEmployees = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? lastDeleteData = freezed,
  }) {
    return _then(_$_EmployeeState(
      currentEmployees: null == currentEmployees
          ? _value._currentEmployees
          : currentEmployees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeM>,
      previousEmployees: null == previousEmployees
          ? _value._previousEmployees
          : previousEmployees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeM>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeStatus,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastDeleteData: freezed == lastDeleteData
          ? _value.lastDeleteData
          : lastDeleteData // ignore: cast_nullable_to_non_nullable
              as EmployeeM?,
    ));
  }
}

/// @nodoc

class _$_EmployeeState implements _EmployeeState {
  const _$_EmployeeState(
      {required final List<EmployeeM> currentEmployees,
      required final List<EmployeeM> previousEmployees,
      required this.status,
      required this.errorMessage,
      required this.lastDeleteData})
      : _currentEmployees = currentEmployees,
        _previousEmployees = previousEmployees;

  final List<EmployeeM> _currentEmployees;
  @override
  List<EmployeeM> get currentEmployees {
    if (_currentEmployees is EqualUnmodifiableListView)
      return _currentEmployees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentEmployees);
  }

  final List<EmployeeM> _previousEmployees;
  @override
  List<EmployeeM> get previousEmployees {
    if (_previousEmployees is EqualUnmodifiableListView)
      return _previousEmployees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousEmployees);
  }

  @override
  final EmployeeStatus status;
  @override
  final String errorMessage;
  @override
  final EmployeeM? lastDeleteData;

  @override
  String toString() {
    return 'EmployeeState(currentEmployees: $currentEmployees, previousEmployees: $previousEmployees, status: $status, errorMessage: $errorMessage, lastDeleteData: $lastDeleteData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmployeeState &&
            const DeepCollectionEquality()
                .equals(other._currentEmployees, _currentEmployees) &&
            const DeepCollectionEquality()
                .equals(other._previousEmployees, _previousEmployees) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastDeleteData, lastDeleteData) ||
                other.lastDeleteData == lastDeleteData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_currentEmployees),
      const DeepCollectionEquality().hash(_previousEmployees),
      status,
      errorMessage,
      lastDeleteData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmployeeStateCopyWith<_$_EmployeeState> get copyWith =>
      __$$_EmployeeStateCopyWithImpl<_$_EmployeeState>(this, _$identity);
}

abstract class _EmployeeState implements EmployeeState {
  const factory _EmployeeState(
      {required final List<EmployeeM> currentEmployees,
      required final List<EmployeeM> previousEmployees,
      required final EmployeeStatus status,
      required final String errorMessage,
      required final EmployeeM? lastDeleteData}) = _$_EmployeeState;

  @override
  List<EmployeeM> get currentEmployees;
  @override
  List<EmployeeM> get previousEmployees;
  @override
  EmployeeStatus get status;
  @override
  String get errorMessage;
  @override
  EmployeeM? get lastDeleteData;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeeStateCopyWith<_$_EmployeeState> get copyWith =>
      throw _privateConstructorUsedError;
}
