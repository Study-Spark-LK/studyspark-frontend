// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'put_documents_document_id_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PutDocumentsDocumentIdResponse {

 Data8 get data;
/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PutDocumentsDocumentIdResponseCopyWith<PutDocumentsDocumentIdResponse> get copyWith => _$PutDocumentsDocumentIdResponseCopyWithImpl<PutDocumentsDocumentIdResponse>(this as PutDocumentsDocumentIdResponse, _$identity);

  /// Serializes this PutDocumentsDocumentIdResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PutDocumentsDocumentIdResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PutDocumentsDocumentIdResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $PutDocumentsDocumentIdResponseCopyWith<$Res>  {
  factory $PutDocumentsDocumentIdResponseCopyWith(PutDocumentsDocumentIdResponse value, $Res Function(PutDocumentsDocumentIdResponse) _then) = _$PutDocumentsDocumentIdResponseCopyWithImpl;
@useResult
$Res call({
 Data8 data
});


$Data8CopyWith<$Res> get data;

}
/// @nodoc
class _$PutDocumentsDocumentIdResponseCopyWithImpl<$Res>
    implements $PutDocumentsDocumentIdResponseCopyWith<$Res> {
  _$PutDocumentsDocumentIdResponseCopyWithImpl(this._self, this._then);

  final PutDocumentsDocumentIdResponse _self;
  final $Res Function(PutDocumentsDocumentIdResponse) _then;

/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data8,
  ));
}
/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data8CopyWith<$Res> get data {
  
  return $Data8CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PutDocumentsDocumentIdResponse].
extension PutDocumentsDocumentIdResponsePatterns on PutDocumentsDocumentIdResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PutDocumentsDocumentIdResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PutDocumentsDocumentIdResponse value)  $default,){
final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PutDocumentsDocumentIdResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data8 data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data8 data)  $default,) {final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data8 data)?  $default,) {final _that = this;
switch (_that) {
case _PutDocumentsDocumentIdResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PutDocumentsDocumentIdResponse implements PutDocumentsDocumentIdResponse {
  const _PutDocumentsDocumentIdResponse({required this.data});
  factory _PutDocumentsDocumentIdResponse.fromJson(Map<String, dynamic> json) => _$PutDocumentsDocumentIdResponseFromJson(json);

@override final  Data8 data;

/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PutDocumentsDocumentIdResponseCopyWith<_PutDocumentsDocumentIdResponse> get copyWith => __$PutDocumentsDocumentIdResponseCopyWithImpl<_PutDocumentsDocumentIdResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PutDocumentsDocumentIdResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PutDocumentsDocumentIdResponse&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PutDocumentsDocumentIdResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$PutDocumentsDocumentIdResponseCopyWith<$Res> implements $PutDocumentsDocumentIdResponseCopyWith<$Res> {
  factory _$PutDocumentsDocumentIdResponseCopyWith(_PutDocumentsDocumentIdResponse value, $Res Function(_PutDocumentsDocumentIdResponse) _then) = __$PutDocumentsDocumentIdResponseCopyWithImpl;
@override @useResult
$Res call({
 Data8 data
});


@override $Data8CopyWith<$Res> get data;

}
/// @nodoc
class __$PutDocumentsDocumentIdResponseCopyWithImpl<$Res>
    implements _$PutDocumentsDocumentIdResponseCopyWith<$Res> {
  __$PutDocumentsDocumentIdResponseCopyWithImpl(this._self, this._then);

  final _PutDocumentsDocumentIdResponse _self;
  final $Res Function(_PutDocumentsDocumentIdResponse) _then;

/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_PutDocumentsDocumentIdResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data8,
  ));
}

/// Create a copy of PutDocumentsDocumentIdResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data8CopyWith<$Res> get data {
  
  return $Data8CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
