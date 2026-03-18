// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_profiles_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteProfilesResponse {

 Data4 get data;
/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteProfilesResponseCopyWith<DeleteProfilesResponse> get copyWith => _$DeleteProfilesResponseCopyWithImpl<DeleteProfilesResponse>(this as DeleteProfilesResponse, _$identity);

  /// Serializes this DeleteProfilesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteProfilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteProfilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $DeleteProfilesResponseCopyWith<$Res>  {
  factory $DeleteProfilesResponseCopyWith(DeleteProfilesResponse value, $Res Function(DeleteProfilesResponse) _then) = _$DeleteProfilesResponseCopyWithImpl;
@useResult
$Res call({
 Data4 data
});


$Data4CopyWith<$Res> get data;

}
/// @nodoc
class _$DeleteProfilesResponseCopyWithImpl<$Res>
    implements $DeleteProfilesResponseCopyWith<$Res> {
  _$DeleteProfilesResponseCopyWithImpl(this._self, this._then);

  final DeleteProfilesResponse _self;
  final $Res Function(DeleteProfilesResponse) _then;

/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data4,
  ));
}
/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data4CopyWith<$Res> get data {
  
  return $Data4CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeleteProfilesResponse].
extension DeleteProfilesResponsePatterns on DeleteProfilesResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteProfilesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteProfilesResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteProfilesResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeleteProfilesResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteProfilesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteProfilesResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data4 data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteProfilesResponse() when $default != null:
return $default(_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data4 data)  $default,) {final _that = this;
switch (_that) {
case _DeleteProfilesResponse():
return $default(_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data4 data)?  $default,) {final _that = this;
switch (_that) {
case _DeleteProfilesResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteProfilesResponse implements DeleteProfilesResponse {
  const _DeleteProfilesResponse({required this.data});
  factory _DeleteProfilesResponse.fromJson(Map<String, dynamic> json) => _$DeleteProfilesResponseFromJson(json);

@override final  Data4 data;

/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteProfilesResponseCopyWith<_DeleteProfilesResponse> get copyWith => __$DeleteProfilesResponseCopyWithImpl<_DeleteProfilesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteProfilesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteProfilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteProfilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DeleteProfilesResponseCopyWith<$Res> implements $DeleteProfilesResponseCopyWith<$Res> {
  factory _$DeleteProfilesResponseCopyWith(_DeleteProfilesResponse value, $Res Function(_DeleteProfilesResponse) _then) = __$DeleteProfilesResponseCopyWithImpl;
@override @useResult
$Res call({
 Data4 data
});


@override $Data4CopyWith<$Res> get data;

}
/// @nodoc
class __$DeleteProfilesResponseCopyWithImpl<$Res>
    implements _$DeleteProfilesResponseCopyWith<$Res> {
  __$DeleteProfilesResponseCopyWithImpl(this._self, this._then);

  final _DeleteProfilesResponse _self;
  final $Res Function(_DeleteProfilesResponse) _then;

/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DeleteProfilesResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data4,
  ));
}

/// Create a copy of DeleteProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data4CopyWith<$Res> get data {
  
  return $Data4CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
