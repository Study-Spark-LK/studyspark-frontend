// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_files.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneratedFiles {

 String get fileId; Type get type;
/// Create a copy of GeneratedFiles
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedFilesCopyWith<GeneratedFiles> get copyWith => _$GeneratedFilesCopyWithImpl<GeneratedFiles>(this as GeneratedFiles, _$identity);

  /// Serializes this GeneratedFiles to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedFiles&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileId,type);

@override
String toString() {
  return 'GeneratedFiles(fileId: $fileId, type: $type)';
}


}

/// @nodoc
abstract mixin class $GeneratedFilesCopyWith<$Res>  {
  factory $GeneratedFilesCopyWith(GeneratedFiles value, $Res Function(GeneratedFiles) _then) = _$GeneratedFilesCopyWithImpl;
@useResult
$Res call({
 String fileId, Type type
});




}
/// @nodoc
class _$GeneratedFilesCopyWithImpl<$Res>
    implements $GeneratedFilesCopyWith<$Res> {
  _$GeneratedFilesCopyWithImpl(this._self, this._then);

  final GeneratedFiles _self;
  final $Res Function(GeneratedFiles) _then;

/// Create a copy of GeneratedFiles
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? type = null,}) {
  return _then(_self.copyWith(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedFiles].
extension GeneratedFilesPatterns on GeneratedFiles {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedFiles value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedFiles() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedFiles value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedFiles():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedFiles value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedFiles() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  Type type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedFiles() when $default != null:
return $default(_that.fileId,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  Type type)  $default,) {final _that = this;
switch (_that) {
case _GeneratedFiles():
return $default(_that.fileId,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  Type type)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedFiles() when $default != null:
return $default(_that.fileId,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratedFiles implements GeneratedFiles {
  const _GeneratedFiles({required this.fileId, required this.type});
  factory _GeneratedFiles.fromJson(Map<String, dynamic> json) => _$GeneratedFilesFromJson(json);

@override final  String fileId;
@override final  Type type;

/// Create a copy of GeneratedFiles
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedFilesCopyWith<_GeneratedFiles> get copyWith => __$GeneratedFilesCopyWithImpl<_GeneratedFiles>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratedFilesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedFiles&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileId,type);

@override
String toString() {
  return 'GeneratedFiles(fileId: $fileId, type: $type)';
}


}

/// @nodoc
abstract mixin class _$GeneratedFilesCopyWith<$Res> implements $GeneratedFilesCopyWith<$Res> {
  factory _$GeneratedFilesCopyWith(_GeneratedFiles value, $Res Function(_GeneratedFiles) _then) = __$GeneratedFilesCopyWithImpl;
@override @useResult
$Res call({
 String fileId, Type type
});




}
/// @nodoc
class __$GeneratedFilesCopyWithImpl<$Res>
    implements _$GeneratedFilesCopyWith<$Res> {
  __$GeneratedFilesCopyWithImpl(this._self, this._then);

  final _GeneratedFiles _self;
  final $Res Function(_GeneratedFiles) _then;

/// Create a copy of GeneratedFiles
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? type = null,}) {
  return _then(_GeneratedFiles(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type,
  ));
}


}

// dart format on
