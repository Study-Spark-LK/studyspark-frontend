// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_profiles_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostProfilesResponse {

 Data3 get data;
/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostProfilesResponseCopyWith<PostProfilesResponse> get copyWith => _$PostProfilesResponseCopyWithImpl<PostProfilesResponse>(this as PostProfilesResponse, _$identity);

  /// Serializes this PostProfilesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostProfilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostProfilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $PostProfilesResponseCopyWith<$Res>  {
  factory $PostProfilesResponseCopyWith(PostProfilesResponse value, $Res Function(PostProfilesResponse) _then) = _$PostProfilesResponseCopyWithImpl;
@useResult
$Res call({
 Data3 data
});


$Data3CopyWith<$Res> get data;

}
/// @nodoc
class _$PostProfilesResponseCopyWithImpl<$Res>
    implements $PostProfilesResponseCopyWith<$Res> {
  _$PostProfilesResponseCopyWithImpl(this._self, this._then);

  final PostProfilesResponse _self;
  final $Res Function(PostProfilesResponse) _then;

/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data3,
  ));
}
/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data3CopyWith<$Res> get data {
  
  return $Data3CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostProfilesResponse].
extension PostProfilesResponsePatterns on PostProfilesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostProfilesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostProfilesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostProfilesResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostProfilesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostProfilesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostProfilesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data3 data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostProfilesResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data3 data)  $default,) {final _that = this;
switch (_that) {
case _PostProfilesResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data3 data)?  $default,) {final _that = this;
switch (_that) {
case _PostProfilesResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostProfilesResponse implements PostProfilesResponse {
  const _PostProfilesResponse({required this.data});
  factory _PostProfilesResponse.fromJson(Map<String, dynamic> json) => _$PostProfilesResponseFromJson(json);

@override final  Data3 data;

/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostProfilesResponseCopyWith<_PostProfilesResponse> get copyWith => __$PostProfilesResponseCopyWithImpl<_PostProfilesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostProfilesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostProfilesResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostProfilesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$PostProfilesResponseCopyWith<$Res> implements $PostProfilesResponseCopyWith<$Res> {
  factory _$PostProfilesResponseCopyWith(_PostProfilesResponse value, $Res Function(_PostProfilesResponse) _then) = __$PostProfilesResponseCopyWithImpl;
@override @useResult
$Res call({
 Data3 data
});


@override $Data3CopyWith<$Res> get data;

}
/// @nodoc
class __$PostProfilesResponseCopyWithImpl<$Res>
    implements _$PostProfilesResponseCopyWith<$Res> {
  __$PostProfilesResponseCopyWithImpl(this._self, this._then);

  final _PostProfilesResponse _self;
  final $Res Function(_PostProfilesResponse) _then;

/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_PostProfilesResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data3,
  ));
}

/// Create a copy of PostProfilesResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data3CopyWith<$Res> get data {
  
  return $Data3CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
