// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error4xx_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Error4xxSchema {

 Error4xxSchemaCode get code; String get message;
/// Create a copy of Error4xxSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Error4xxSchemaCopyWith<Error4xxSchema> get copyWith => _$Error4xxSchemaCopyWithImpl<Error4xxSchema>(this as Error4xxSchema, _$identity);

  /// Serializes this Error4xxSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error4xxSchema&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'Error4xxSchema(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $Error4xxSchemaCopyWith<$Res>  {
  factory $Error4xxSchemaCopyWith(Error4xxSchema value, $Res Function(Error4xxSchema) _then) = _$Error4xxSchemaCopyWithImpl;
@useResult
$Res call({
 Error4xxSchemaCode code, String message
});




}
/// @nodoc
class _$Error4xxSchemaCopyWithImpl<$Res>
    implements $Error4xxSchemaCopyWith<$Res> {
  _$Error4xxSchemaCopyWithImpl(this._self, this._then);

  final Error4xxSchema _self;
  final $Res Function(Error4xxSchema) _then;

/// Create a copy of Error4xxSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as Error4xxSchemaCode,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Error4xxSchema].
extension Error4xxSchemaPatterns on Error4xxSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Error4xxSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Error4xxSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Error4xxSchema value)  $default,){
final _that = this;
switch (_that) {
case _Error4xxSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Error4xxSchema value)?  $default,){
final _that = this;
switch (_that) {
case _Error4xxSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Error4xxSchemaCode code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Error4xxSchema() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Error4xxSchemaCode code,  String message)  $default,) {final _that = this;
switch (_that) {
case _Error4xxSchema():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Error4xxSchemaCode code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _Error4xxSchema() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Error4xxSchema implements Error4xxSchema {
  const _Error4xxSchema({required this.code, required this.message});
  factory _Error4xxSchema.fromJson(Map<String, dynamic> json) => _$Error4xxSchemaFromJson(json);

@override final  Error4xxSchemaCode code;
@override final  String message;

/// Create a copy of Error4xxSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Error4xxSchemaCopyWith<_Error4xxSchema> get copyWith => __$Error4xxSchemaCopyWithImpl<_Error4xxSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Error4xxSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error4xxSchema&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'Error4xxSchema(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$Error4xxSchemaCopyWith<$Res> implements $Error4xxSchemaCopyWith<$Res> {
  factory _$Error4xxSchemaCopyWith(_Error4xxSchema value, $Res Function(_Error4xxSchema) _then) = __$Error4xxSchemaCopyWithImpl;
@override @useResult
$Res call({
 Error4xxSchemaCode code, String message
});




}
/// @nodoc
class __$Error4xxSchemaCopyWithImpl<$Res>
    implements _$Error4xxSchemaCopyWith<$Res> {
  __$Error4xxSchemaCopyWithImpl(this._self, this._then);

  final _Error4xxSchema _self;
  final $Res Function(_Error4xxSchema) _then;

/// Create a copy of Error4xxSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_Error4xxSchema(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as Error4xxSchemaCode,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
