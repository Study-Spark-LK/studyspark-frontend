// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data4.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Data4 {

 String get id; String get name; Status get status; num get visualScore; num get auditoryScore; num get readingScore; num get kinestheticScore; num get createdAt; num get updatedAt;
/// Create a copy of Data4
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Data4CopyWith<Data4> get copyWith => _$Data4CopyWithImpl<Data4>(this as Data4, _$identity);

  /// Serializes this Data4 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data4&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.auditoryScore, auditoryScore) || other.auditoryScore == auditoryScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.kinestheticScore, kinestheticScore) || other.kinestheticScore == kinestheticScore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,visualScore,auditoryScore,readingScore,kinestheticScore,createdAt,updatedAt);

@override
String toString() {
  return 'Data4(id: $id, name: $name, status: $status, visualScore: $visualScore, auditoryScore: $auditoryScore, readingScore: $readingScore, kinestheticScore: $kinestheticScore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $Data4CopyWith<$Res>  {
  factory $Data4CopyWith(Data4 value, $Res Function(Data4) _then) = _$Data4CopyWithImpl;
@useResult
$Res call({
 String id, String name, Status status, num visualScore, num auditoryScore, num readingScore, num kinestheticScore, num createdAt, num updatedAt
});




}
/// @nodoc
class _$Data4CopyWithImpl<$Res>
    implements $Data4CopyWith<$Res> {
  _$Data4CopyWithImpl(this._self, this._then);

  final Data4 _self;
  final $Res Function(Data4) _then;

/// Create a copy of Data4
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? visualScore = null,Object? auditoryScore = null,Object? readingScore = null,Object? kinestheticScore = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as num,auditoryScore: null == auditoryScore ? _self.auditoryScore : auditoryScore // ignore: cast_nullable_to_non_nullable
as num,readingScore: null == readingScore ? _self.readingScore : readingScore // ignore: cast_nullable_to_non_nullable
as num,kinestheticScore: null == kinestheticScore ? _self.kinestheticScore : kinestheticScore // ignore: cast_nullable_to_non_nullable
as num,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [Data4].
extension Data4Patterns on Data4 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data4 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data4() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data4 value)  $default,){
final _that = this;
switch (_that) {
case _Data4():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data4 value)?  $default,){
final _that = this;
switch (_that) {
case _Data4() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  num createdAt,  num updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data4() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.visualScore,_that.auditoryScore,_that.readingScore,_that.kinestheticScore,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  num createdAt,  num updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Data4():
return $default(_that.id,_that.name,_that.status,_that.visualScore,_that.auditoryScore,_that.readingScore,_that.kinestheticScore,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  num createdAt,  num updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Data4() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.visualScore,_that.auditoryScore,_that.readingScore,_that.kinestheticScore,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data4 implements Data4 {
  const _Data4({required this.id, required this.name, required this.status, required this.visualScore, required this.auditoryScore, required this.readingScore, required this.kinestheticScore, required this.createdAt, required this.updatedAt});
  factory _Data4.fromJson(Map<String, dynamic> json) => _$Data4FromJson(json);

@override final  String id;
@override final  String name;
@override final  Status status;
@override final  num visualScore;
@override final  num auditoryScore;
@override final  num readingScore;
@override final  num kinestheticScore;
@override final  num createdAt;
@override final  num updatedAt;

/// Create a copy of Data4
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Data4CopyWith<_Data4> get copyWith => __$Data4CopyWithImpl<_Data4>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Data4ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data4&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.auditoryScore, auditoryScore) || other.auditoryScore == auditoryScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.kinestheticScore, kinestheticScore) || other.kinestheticScore == kinestheticScore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,visualScore,auditoryScore,readingScore,kinestheticScore,createdAt,updatedAt);

@override
String toString() {
  return 'Data4(id: $id, name: $name, status: $status, visualScore: $visualScore, auditoryScore: $auditoryScore, readingScore: $readingScore, kinestheticScore: $kinestheticScore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$Data4CopyWith<$Res> implements $Data4CopyWith<$Res> {
  factory _$Data4CopyWith(_Data4 value, $Res Function(_Data4) _then) = __$Data4CopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Status status, num visualScore, num auditoryScore, num readingScore, num kinestheticScore, num createdAt, num updatedAt
});




}
/// @nodoc
class __$Data4CopyWithImpl<$Res>
    implements _$Data4CopyWith<$Res> {
  __$Data4CopyWithImpl(this._self, this._then);

  final _Data4 _self;
  final $Res Function(_Data4) _then;

/// Create a copy of Data4
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? visualScore = null,Object? auditoryScore = null,Object? readingScore = null,Object? kinestheticScore = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Data4(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as num,auditoryScore: null == auditoryScore ? _self.auditoryScore : auditoryScore // ignore: cast_nullable_to_non_nullable
as num,readingScore: null == readingScore ? _self.readingScore : readingScore // ignore: cast_nullable_to_non_nullable
as num,kinestheticScore: null == kinestheticScore ? _self.kinestheticScore : kinestheticScore // ignore: cast_nullable_to_non_nullable
as num,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
