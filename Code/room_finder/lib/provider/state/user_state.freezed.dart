// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() failedRead,
    required TResult Function(UserData userData) successfulRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? failedRead,
    TResult? Function(UserData userData)? successfulRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? failedRead,
    TResult Function(UserData userData)? successfulRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FailedRead value) failedRead,
    required TResult Function(_SuccessfulRead value) successfulRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FailedRead value)? failedRead,
    TResult? Function(_SuccessfulRead value)? successfulRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_FailedRead value)? failedRead,
    TResult Function(_SuccessfulRead value)? successfulRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'UserState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() failedRead,
    required TResult Function(UserData userData) successfulRead,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? failedRead,
    TResult? Function(UserData userData)? successfulRead,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? failedRead,
    TResult Function(UserData userData)? successfulRead,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FailedRead value) failedRead,
    required TResult Function(_SuccessfulRead value) successfulRead,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FailedRead value)? failedRead,
    TResult? Function(_SuccessfulRead value)? successfulRead,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_FailedRead value)? failedRead,
    TResult Function(_SuccessfulRead value)? successfulRead,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'UserState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() failedRead,
    required TResult Function(UserData userData) successfulRead,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? failedRead,
    TResult? Function(UserData userData)? successfulRead,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? failedRead,
    TResult Function(UserData userData)? successfulRead,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FailedRead value) failedRead,
    required TResult Function(_SuccessfulRead value) successfulRead,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FailedRead value)? failedRead,
    TResult? Function(_SuccessfulRead value)? successfulRead,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_FailedRead value)? failedRead,
    TResult Function(_SuccessfulRead value)? successfulRead,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UserState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$FailedReadImplCopyWith<$Res> {
  factory _$$FailedReadImplCopyWith(
          _$FailedReadImpl value, $Res Function(_$FailedReadImpl) then) =
      __$$FailedReadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailedReadImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$FailedReadImpl>
    implements _$$FailedReadImplCopyWith<$Res> {
  __$$FailedReadImplCopyWithImpl(
      _$FailedReadImpl _value, $Res Function(_$FailedReadImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FailedReadImpl with DiagnosticableTreeMixin implements _FailedRead {
  const _$FailedReadImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.failedRead()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'UserState.failedRead'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailedReadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() failedRead,
    required TResult Function(UserData userData) successfulRead,
  }) {
    return failedRead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? failedRead,
    TResult? Function(UserData userData)? successfulRead,
  }) {
    return failedRead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? failedRead,
    TResult Function(UserData userData)? successfulRead,
    required TResult orElse(),
  }) {
    if (failedRead != null) {
      return failedRead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FailedRead value) failedRead,
    required TResult Function(_SuccessfulRead value) successfulRead,
  }) {
    return failedRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FailedRead value)? failedRead,
    TResult? Function(_SuccessfulRead value)? successfulRead,
  }) {
    return failedRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_FailedRead value)? failedRead,
    TResult Function(_SuccessfulRead value)? successfulRead,
    required TResult orElse(),
  }) {
    if (failedRead != null) {
      return failedRead(this);
    }
    return orElse();
  }
}

abstract class _FailedRead implements UserState {
  const factory _FailedRead() = _$FailedReadImpl;
}

/// @nodoc
abstract class _$$SuccessfulReadImplCopyWith<$Res> {
  factory _$$SuccessfulReadImplCopyWith(_$SuccessfulReadImpl value,
          $Res Function(_$SuccessfulReadImpl) then) =
      __$$SuccessfulReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserData userData});
}

/// @nodoc
class __$$SuccessfulReadImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$SuccessfulReadImpl>
    implements _$$SuccessfulReadImplCopyWith<$Res> {
  __$$SuccessfulReadImplCopyWithImpl(
      _$SuccessfulReadImpl _value, $Res Function(_$SuccessfulReadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
  }) {
    return _then(_$SuccessfulReadImpl(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData,
    ));
  }
}

/// @nodoc

class _$SuccessfulReadImpl
    with DiagnosticableTreeMixin
    implements _SuccessfulRead {
  const _$SuccessfulReadImpl({required this.userData});

  @override
  final UserData userData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.successfulRead(userData: $userData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserState.successfulRead'))
      ..add(DiagnosticsProperty('userData', userData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessfulReadImpl &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessfulReadImplCopyWith<_$SuccessfulReadImpl> get copyWith =>
      __$$SuccessfulReadImplCopyWithImpl<_$SuccessfulReadImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() failedRead,
    required TResult Function(UserData userData) successfulRead,
  }) {
    return successfulRead(userData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? failedRead,
    TResult? Function(UserData userData)? successfulRead,
  }) {
    return successfulRead?.call(userData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? failedRead,
    TResult Function(UserData userData)? successfulRead,
    required TResult orElse(),
  }) {
    if (successfulRead != null) {
      return successfulRead(userData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FailedRead value) failedRead,
    required TResult Function(_SuccessfulRead value) successfulRead,
  }) {
    return successfulRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FailedRead value)? failedRead,
    TResult? Function(_SuccessfulRead value)? successfulRead,
  }) {
    return successfulRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_FailedRead value)? failedRead,
    TResult Function(_SuccessfulRead value)? successfulRead,
    required TResult orElse(),
  }) {
    if (successfulRead != null) {
      return successfulRead(this);
    }
    return orElse();
  }
}

abstract class _SuccessfulRead implements UserState {
  const factory _SuccessfulRead({required final UserData userData}) =
      _$SuccessfulReadImpl;

  UserData get userData;
  @JsonKey(ignore: true)
  _$$SuccessfulReadImplCopyWith<_$SuccessfulReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
