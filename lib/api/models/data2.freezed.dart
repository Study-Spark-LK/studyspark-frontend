// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Data2 {

 String get id; String get name; Status get status; num get visualScore; num get auditoryScore; num get readingScore; num get kinestheticScore; Object? get createdAt; Object? get updatedAt;
/// Create a copy of Data2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Data2CopyWith<Data2> get copyWith => _$Data2CopyWithImpl<Data2>(this as Data2, _$identity);

  /// Serializes this Data2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data2&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.auditoryScore, auditoryScore) || other.auditoryScore == auditoryScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.kinestheticScore, kinestheticScore) || other.kinestheticScore == kinestheticScore)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,visualScore,auditoryScore,readingScore,kinestheticScore,const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(updatedAt));

@override
String toString() {
  return 'Data2(id: $id, name: $name, status: $status, visualScore: $visualScore, auditoryScore: $auditoryScore, readingScore: $readingScore, kinestheticScore: $kinestheticScore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $Data2CopyWith<$Res>  {
  factory $Data2CopyWith(Data2 value, $Res Function(Data2) _then) = _$Data2CopyWithImpl;
@useResult
$Res call({
 String id, String name, Status status, num visualScore, num auditoryScore, num readingScore, num kinestheticScore, Object? createdAt, Object? updatedAt
});




}
/// @nodoc
class _$Data2CopyWithImpl<$Res>
    implements $Data2CopyWith<$Res> {
  _$Data2CopyWithImpl(this._self, this._then);

  final Data2 _self;
  final $Res Function(Data2) _then;

/// Create a copy of Data2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? visualScore = null,Object? auditoryScore = null,Object? readingScore = null,Object? kinestheticScore = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as num,auditoryScore: null == auditoryScore ? _self.auditoryScore : auditoryScore // ignore: cast_nullable_to_non_nullable
as num,readingScore: null == readingScore ? _self.readingScore : readingScore // ignore: cast_nullable_to_non_nullable
as num,kinestheticScore: null == kinestheticScore ? _self.kinestheticScore : kinestheticScore // ignore: cast_nullable_to_non_nullable
as num,createdAt: freezed == createdAt ? _self.createdAt : createdAt ,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt ,
  ));
}

}


/// Adds pattern-matching-related methods to [Data2].
extension Data2Patterns on Data2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data2 value)  $default,){
final _that = this;
switch (_that) {
case _Data2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data2 value)?  $default,){
final _that = this;
switch (_that) {
case _Data2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  Object? createdAt,  Object? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data2() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  Object? createdAt,  Object? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Data2():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Status status,  num visualScore,  num auditoryScore,  num readingScore,  num kinestheticScore,  Object? createdAt,  Object? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Data2() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.visualScore,_that.auditoryScore,_that.readingScore,_that.kinestheticScore,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data2 implements Data2 {
  const _Data2({required this.id, required this.name, required this.status, this.visualScore = 0, this.auditoryScore = 0, this.readingScore = 0, this.kinestheticScore = 0, this.createdAt, this.updatedAt});
  factory _Data2.fromJson(Map<String, dynamic> json) => _$Data2FromJson(json);

@override final  String id;
@override final  String name;
@override final  Status status;
@override@JsonKey() final  num visualScore;
@override@JsonKey() final  num auditoryScore;
@override@JsonKey() final  num readingScore;
@override@JsonKey() final  num kinestheticScore;
@override final  Object? createdAt;
@override final  Object? updatedAt;

/// Create a copy of Data2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Data2CopyWith<_Data2> get copyWith => __$Data2CopyWithImpl<_Data2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Data2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data2&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.auditoryScore, auditoryScore) || other.auditoryScore == auditoryScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.kinestheticScore, kinestheticScore) || other.kinestheticScore == kinestheticScore)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,visualScore,auditoryScore,readingScore,kinestheticScore,const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(updatedAt));

@override
String toString() {
  return 'Data2(id: $id, name: $name, status: $status, visualScore: $visualScore, auditoryScore: $auditoryScore, readingScore: $readingScore, kinestheticScore: $kinestheticScore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$Data2CopyWith<$Res> implements $Data2CopyWith<$Res> {
  factory _$Data2CopyWith(_Data2 value, $Res Function(_Data2) _then) = __$Data2CopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Status status, num visualScore, num auditoryScore, num readingScore, num kinestheticScore, Object? createdAt, Object? updatedAt
});




}
/// @nodoc
class __$Data2CopyWithImpl<$Res>
    implements _$Data2CopyWith<$Res> {
  __$Data2CopyWithImpl(this._self, this._then);

  final _Data2 _self;
  final $Res Function(_Data2) _then;

/// Create a copy of Data2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? visualScore = null,Object? auditoryScore = null,Object? readingScore = null,Object? kinestheticScore = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Data2(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as num,auditoryScore: null == auditoryScore ? _self.auditoryScore : auditoryScore // ignore: cast_nullable_to_non_nullable
as num,readingScore: null == readingScore ? _self.readingScore : readingScore // ignore: cast_nullable_to_non_nullable
as num,kinestheticScore: null == kinestheticScore ? _self.kinestheticScore : kinestheticScore // ignore: cast_nullable_to_non_nullable
as num,createdAt: freezed == createdAt ? _self.createdAt : createdAt ,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt ,
  ));
}


}

// dart format on
