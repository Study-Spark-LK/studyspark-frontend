// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_documents_document_id_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetDocumentsDocumentIdResponse {

 Data7 get data;
/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetDocumentsDocumentIdResponseCopyWith<GetDocumentsDocumentIdResponse> get copyWith => _$GetDocumentsDocumentIdResponseCopyWithImpl<GetDocumentsDocumentIdResponse>(this as GetDocumentsDocumentIdResponse, _$identity);

  /// Serializes this GetDocumentsDocumentIdResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetDocumentsDocumentIdResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'GetDocumentsDocumentIdResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $GetDocumentsDocumentIdResponseCopyWith<$Res>  {
  factory $GetDocumentsDocumentIdResponseCopyWith(GetDocumentsDocumentIdResponse value, $Res Function(GetDocumentsDocumentIdResponse) _then) = _$GetDocumentsDocumentIdResponseCopyWithImpl;
@useResult
$Res call({
 Data7 data
});


$Data7CopyWith<$Res> get data;

}
/// @nodoc
class _$GetDocumentsDocumentIdResponseCopyWithImpl<$Res>
    implements $GetDocumentsDocumentIdResponseCopyWith<$Res> {
  _$GetDocumentsDocumentIdResponseCopyWithImpl(this._self, this._then);

  final GetDocumentsDocumentIdResponse _self;
  final $Res Function(GetDocumentsDocumentIdResponse) _then;

/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data7,
  ));
}
/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data7CopyWith<$Res> get data {
  
  return $Data7CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetDocumentsDocumentIdResponse].
extension GetDocumentsDocumentIdResponsePatterns on GetDocumentsDocumentIdResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetDocumentsDocumentIdResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetDocumentsDocumentIdResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetDocumentsDocumentIdResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data7 data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data7 data)  $default,) {final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data7 data)?  $default,) {final _that = this;
switch (_that) {
case _GetDocumentsDocumentIdResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetDocumentsDocumentIdResponse implements GetDocumentsDocumentIdResponse {
  const _GetDocumentsDocumentIdResponse({required this.data});
  factory _GetDocumentsDocumentIdResponse.fromJson(Map<String, dynamic> json) => _$GetDocumentsDocumentIdResponseFromJson(json);

@override final  Data7 data;

/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDocumentsDocumentIdResponseCopyWith<_GetDocumentsDocumentIdResponse> get copyWith => __$GetDocumentsDocumentIdResponseCopyWithImpl<_GetDocumentsDocumentIdResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetDocumentsDocumentIdResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDocumentsDocumentIdResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'GetDocumentsDocumentIdResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$GetDocumentsDocumentIdResponseCopyWith<$Res> implements $GetDocumentsDocumentIdResponseCopyWith<$Res> {
  factory _$GetDocumentsDocumentIdResponseCopyWith(_GetDocumentsDocumentIdResponse value, $Res Function(_GetDocumentsDocumentIdResponse) _then) = __$GetDocumentsDocumentIdResponseCopyWithImpl;
@override @useResult
$Res call({
 Data7 data
});


@override $Data7CopyWith<$Res> get data;

}
/// @nodoc
class __$GetDocumentsDocumentIdResponseCopyWithImpl<$Res>
    implements _$GetDocumentsDocumentIdResponseCopyWith<$Res> {
  __$GetDocumentsDocumentIdResponseCopyWithImpl(this._self, this._then);

  final _GetDocumentsDocumentIdResponse _self;
  final $Res Function(_GetDocumentsDocumentIdResponse) _then;

/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_GetDocumentsDocumentIdResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data7,
  ));
}

/// Create a copy of GetDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data7CopyWith<$Res> get data {
  
  return $Data7CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
