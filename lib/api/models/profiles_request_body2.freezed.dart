// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profiles_request_body2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfilesRequestBody2 {

 String get id;
/// Create a copy of ProfilesRequestBody2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilesRequestBody2CopyWith<ProfilesRequestBody2> get copyWith => _$ProfilesRequestBody2CopyWithImpl<ProfilesRequestBody2>(this as ProfilesRequestBody2, _$identity);

  /// Serializes this ProfilesRequestBody2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilesRequestBody2&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProfilesRequestBody2(id: $id)';
}


}

/// @nodoc
abstract mixin class $ProfilesRequestBody2CopyWith<$Res>  {
  factory $ProfilesRequestBody2CopyWith(ProfilesRequestBody2 value, $Res Function(ProfilesRequestBody2) _then) = _$ProfilesRequestBody2CopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ProfilesRequestBody2CopyWithImpl<$Res>
    implements $ProfilesRequestBody2CopyWith<$Res> {
  _$ProfilesRequestBody2CopyWithImpl(this._self, this._then);

  final ProfilesRequestBody2 _self;
  final $Res Function(ProfilesRequestBody2) _then;

/// Create a copy of ProfilesRequestBody2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfilesRequestBody2].
extension ProfilesRequestBody2Patterns on ProfilesRequestBody2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilesRequestBody2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilesRequestBody2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilesRequestBody2 value)  $default,){
final _that = this;
switch (_that) {
case _ProfilesRequestBody2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilesRequestBody2 value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilesRequestBody2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilesRequestBody2() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _ProfilesRequestBody2():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _ProfilesRequestBody2() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfilesRequestBody2 implements ProfilesRequestBody2 {
  const _ProfilesRequestBody2({required this.id});
  factory _ProfilesRequestBody2.fromJson(Map<String, dynamic> json) => _$ProfilesRequestBody2FromJson(json);

@override final  String id;

/// Create a copy of ProfilesRequestBody2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilesRequestBody2CopyWith<_ProfilesRequestBody2> get copyWith => __$ProfilesRequestBody2CopyWithImpl<_ProfilesRequestBody2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfilesRequestBody2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilesRequestBody2&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProfilesRequestBody2(id: $id)';
}


}

/// @nodoc
abstract mixin class _$ProfilesRequestBody2CopyWith<$Res> implements $ProfilesRequestBody2CopyWith<$Res> {
  factory _$ProfilesRequestBody2CopyWith(_ProfilesRequestBody2 value, $Res Function(_ProfilesRequestBody2) _then) = __$ProfilesRequestBody2CopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$ProfilesRequestBody2CopyWithImpl<$Res>
    implements _$ProfilesRequestBody2CopyWith<$Res> {
  __$ProfilesRequestBody2CopyWithImpl(this._self, this._then);

  final _ProfilesRequestBody2 _self;
  final $Res Function(_ProfilesRequestBody2) _then;

/// Create a copy of ProfilesRequestBody2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_ProfilesRequestBody2(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
