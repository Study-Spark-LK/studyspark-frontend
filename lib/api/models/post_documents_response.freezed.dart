// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_documents_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDocumentsResponse {

 Data6 get data;
/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDocumentsResponseCopyWith<PostDocumentsResponse> get copyWith => _$PostDocumentsResponseCopyWithImpl<PostDocumentsResponse>(this as PostDocumentsResponse, _$identity);

  /// Serializes this PostDocumentsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDocumentsResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostDocumentsResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $PostDocumentsResponseCopyWith<$Res>  {
  factory $PostDocumentsResponseCopyWith(PostDocumentsResponse value, $Res Function(PostDocumentsResponse) _then) = _$PostDocumentsResponseCopyWithImpl;
@useResult
$Res call({
 Data6 data
});


$Data6CopyWith<$Res> get data;

}
/// @nodoc
class _$PostDocumentsResponseCopyWithImpl<$Res>
    implements $PostDocumentsResponseCopyWith<$Res> {
  _$PostDocumentsResponseCopyWithImpl(this._self, this._then);

  final PostDocumentsResponse _self;
  final $Res Function(PostDocumentsResponse) _then;

/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data6,
  ));
}
/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data6CopyWith<$Res> get data {
  
  return $Data6CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDocumentsResponse].
extension PostDocumentsResponsePatterns on PostDocumentsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDocumentsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDocumentsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDocumentsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostDocumentsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDocumentsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostDocumentsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data6 data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDocumentsResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data6 data)  $default,) {final _that = this;
switch (_that) {
case _PostDocumentsResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data6 data)?  $default,) {final _that = this;
switch (_that) {
case _PostDocumentsResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDocumentsResponse implements PostDocumentsResponse {
  const _PostDocumentsResponse({required this.data});
  factory _PostDocumentsResponse.fromJson(Map<String, dynamic> json) => _$PostDocumentsResponseFromJson(json);

@override final  Data6 data;

/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDocumentsResponseCopyWith<_PostDocumentsResponse> get copyWith => __$PostDocumentsResponseCopyWithImpl<_PostDocumentsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDocumentsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDocumentsResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostDocumentsResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$PostDocumentsResponseCopyWith<$Res> implements $PostDocumentsResponseCopyWith<$Res> {
  factory _$PostDocumentsResponseCopyWith(_PostDocumentsResponse value, $Res Function(_PostDocumentsResponse) _then) = __$PostDocumentsResponseCopyWithImpl;
@override @useResult
$Res call({
 Data6 data
});


@override $Data6CopyWith<$Res> get data;

}
/// @nodoc
class __$PostDocumentsResponseCopyWithImpl<$Res>
    implements _$PostDocumentsResponseCopyWith<$Res> {
  __$PostDocumentsResponseCopyWithImpl(this._self, this._then);

  final _PostDocumentsResponse _self;
  final $Res Function(_PostDocumentsResponse) _then;

/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_PostDocumentsResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data6,
  ));
}

/// Create a copy of PostDocumentsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data6CopyWith<$Res> get data {
  
  return $Data6CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
