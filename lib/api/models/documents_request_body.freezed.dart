// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'documents_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentsRequestBody {

 String get fileId; String get profileId;
/// Create a copy of DocumentsRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentsRequestBodyCopyWith<DocumentsRequestBody> get copyWith => _$DocumentsRequestBodyCopyWithImpl<DocumentsRequestBody>(this as DocumentsRequestBody, _$identity);

  /// Serializes this DocumentsRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentsRequestBody&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.profileId, profileId) || other.profileId == profileId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileId,profileId);

@override
String toString() {
  return 'DocumentsRequestBody(fileId: $fileId, profileId: $profileId)';
}


}

/// @nodoc
abstract mixin class $DocumentsRequestBodyCopyWith<$Res>  {
  factory $DocumentsRequestBodyCopyWith(DocumentsRequestBody value, $Res Function(DocumentsRequestBody) _then) = _$DocumentsRequestBodyCopyWithImpl;
@useResult
$Res call({
 String fileId, String profileId
});




}
/// @nodoc
class _$DocumentsRequestBodyCopyWithImpl<$Res>
    implements $DocumentsRequestBodyCopyWith<$Res> {
  _$DocumentsRequestBodyCopyWithImpl(this._self, this._then);

  final DocumentsRequestBody _self;
  final $Res Function(DocumentsRequestBody) _then;

/// Create a copy of DocumentsRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? profileId = null,}) {
  return _then(_self.copyWith(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentsRequestBody].
extension DocumentsRequestBodyPatterns on DocumentsRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentsRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentsRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentsRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _DocumentsRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentsRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentsRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  String profileId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentsRequestBody() when $default != null:
return $default(_that.fileId,_that.profileId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  String profileId)  $default,) {final _that = this;
switch (_that) {
case _DocumentsRequestBody():
return $default(_that.fileId,_that.profileId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  String profileId)?  $default,) {final _that = this;
switch (_that) {
case _DocumentsRequestBody() when $default != null:
return $default(_that.fileId,_that.profileId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentsRequestBody implements DocumentsRequestBody {
  const _DocumentsRequestBody({required this.fileId, required this.profileId});
  factory _DocumentsRequestBody.fromJson(Map<String, dynamic> json) => _$DocumentsRequestBodyFromJson(json);

@override final  String fileId;
@override final  String profileId;

/// Create a copy of DocumentsRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentsRequestBodyCopyWith<_DocumentsRequestBody> get copyWith => __$DocumentsRequestBodyCopyWithImpl<_DocumentsRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentsRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentsRequestBody&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.profileId, profileId) || other.profileId == profileId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileId,profileId);

@override
String toString() {
  return 'DocumentsRequestBody(fileId: $fileId, profileId: $profileId)';
}


}

/// @nodoc
abstract mixin class _$DocumentsRequestBodyCopyWith<$Res> implements $DocumentsRequestBodyCopyWith<$Res> {
  factory _$DocumentsRequestBodyCopyWith(_DocumentsRequestBody value, $Res Function(_DocumentsRequestBody) _then) = __$DocumentsRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String fileId, String profileId
});




}
/// @nodoc
class __$DocumentsRequestBodyCopyWithImpl<$Res>
    implements _$DocumentsRequestBodyCopyWith<$Res> {
  __$DocumentsRequestBodyCopyWithImpl(this._self, this._then);

  final _DocumentsRequestBody _self;
  final $Res Function(_DocumentsRequestBody) _then;

/// Create a copy of DocumentsRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? profileId = null,}) {
  return _then(_DocumentsRequestBody(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
