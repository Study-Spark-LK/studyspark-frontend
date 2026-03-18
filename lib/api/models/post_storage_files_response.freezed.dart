// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_storage_files_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostStorageFilesResponse {

 Data get data;
/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostStorageFilesResponseCopyWith<PostStorageFilesResponse> get copyWith => _$PostStorageFilesResponseCopyWithImpl<PostStorageFilesResponse>(this as PostStorageFilesResponse, _$identity);

  /// Serializes this PostStorageFilesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostStorageFilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostStorageFilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $PostStorageFilesResponseCopyWith<$Res>  {
  factory $PostStorageFilesResponseCopyWith(PostStorageFilesResponse value, $Res Function(PostStorageFilesResponse) _then) = _$PostStorageFilesResponseCopyWithImpl;
@useResult
$Res call({
 Data data
});


$DataCopyWith<$Res> get data;

}
/// @nodoc
class _$PostStorageFilesResponseCopyWithImpl<$Res>
    implements $PostStorageFilesResponseCopyWith<$Res> {
  _$PostStorageFilesResponseCopyWithImpl(this._self, this._then);

  final PostStorageFilesResponse _self;
  final $Res Function(PostStorageFilesResponse) _then;

/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data,
  ));
}
/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res> get data {
  
  return $DataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostStorageFilesResponse].
extension PostStorageFilesResponsePatterns on PostStorageFilesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostStorageFilesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostStorageFilesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostStorageFilesResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostStorageFilesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostStorageFilesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostStorageFilesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostStorageFilesResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data data)  $default,) {final _that = this;
switch (_that) {
case _PostStorageFilesResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data data)?  $default,) {final _that = this;
switch (_that) {
case _PostStorageFilesResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostStorageFilesResponse implements PostStorageFilesResponse {
  const _PostStorageFilesResponse({required this.data});
  factory _PostStorageFilesResponse.fromJson(Map<String, dynamic> json) => _$PostStorageFilesResponseFromJson(json);

@override final  Data data;

/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostStorageFilesResponseCopyWith<_PostStorageFilesResponse> get copyWith => __$PostStorageFilesResponseCopyWithImpl<_PostStorageFilesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostStorageFilesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostStorageFilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostStorageFilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$PostStorageFilesResponseCopyWith<$Res> implements $PostStorageFilesResponseCopyWith<$Res> {
  factory _$PostStorageFilesResponseCopyWith(_PostStorageFilesResponse value, $Res Function(_PostStorageFilesResponse) _then) = __$PostStorageFilesResponseCopyWithImpl;
@override @useResult
$Res call({
 Data data
});


@override $DataCopyWith<$Res> get data;

}
/// @nodoc
class __$PostStorageFilesResponseCopyWithImpl<$Res>
    implements _$PostStorageFilesResponseCopyWith<$Res> {
  __$PostStorageFilesResponseCopyWithImpl(this._self, this._then);

  final _PostStorageFilesResponse _self;
  final $Res Function(_PostStorageFilesResponse) _then;

/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_PostStorageFilesResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data,
  ));
}

/// Create a copy of PostStorageFilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res> get data {
  
  return $DataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
