// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data5.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Data5 {

 String get id; String get profileId; Status get status; String? get title; String? get description; String? get category; num get progressPercentage;
/// Create a copy of Data5
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Data5CopyWith<Data5> get copyWith => _$Data5CopyWithImpl<Data5>(this as Data5, _$identity);

  /// Serializes this Data5 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data5&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,status,title,description,category,progressPercentage);

@override
String toString() {
  return 'Data5(id: $id, profileId: $profileId, status: $status, title: $title, description: $description, category: $category, progressPercentage: $progressPercentage)';
}


}

/// @nodoc
abstract mixin class $Data5CopyWith<$Res>  {
  factory $Data5CopyWith(Data5 value, $Res Function(Data5) _then) = _$Data5CopyWithImpl;
@useResult
$Res call({
 String id, String profileId, Status status, String? title, String? description, String? category, num progressPercentage
});




}
/// @nodoc
class _$Data5CopyWithImpl<$Res>
    implements $Data5CopyWith<$Res> {
  _$Data5CopyWithImpl(this._self, this._then);

  final Data5 _self;
  final $Res Function(Data5) _then;

/// Create a copy of Data5
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? status = null,Object? title = freezed,Object? description = freezed,Object? category = freezed,Object? progressPercentage = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [Data5].
extension Data5Patterns on Data5 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data5 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data5() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data5 value)  $default,){
final _that = this;
switch (_that) {
case _Data5():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data5 value)?  $default,){
final _that = this;
switch (_that) {
case _Data5() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  Status status,  String? title,  String? description,  String? category,  num progressPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data5() when $default != null:
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  Status status,  String? title,  String? description,  String? category,  num progressPercentage)  $default,) {final _that = this;
switch (_that) {
case _Data5():
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  Status status,  String? title,  String? description,  String? category,  num progressPercentage)?  $default,) {final _that = this;
switch (_that) {
case _Data5() when $default != null:
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data5 implements Data5 {
  const _Data5({required this.id, required this.profileId, required this.status, this.title, this.description, this.category, required this.progressPercentage});
  factory _Data5.fromJson(Map<String, dynamic> json) => _$Data5FromJson(json);

@override final  String id;
@override final  String profileId;
@override final  Status status;
@override final  String? title;
@override final  String? description;
@override final  String? category;
@override final  num progressPercentage;

/// Create a copy of Data5
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Data5CopyWith<_Data5> get copyWith => __$Data5CopyWithImpl<_Data5>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Data5ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data5&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,status,title,description,category,progressPercentage);

@override
String toString() {
  return 'Data5(id: $id, profileId: $profileId, status: $status, title: $title, description: $description, category: $category, progressPercentage: $progressPercentage)';
}


}

/// @nodoc
abstract mixin class _$Data5CopyWith<$Res> implements $Data5CopyWith<$Res> {
  factory _$Data5CopyWith(_Data5 value, $Res Function(_Data5) _then) = __$Data5CopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, Status status, String? title, String? description, String? category, num progressPercentage
});




}
/// @nodoc
class __$Data5CopyWithImpl<$Res>
    implements _$Data5CopyWith<$Res> {
  __$Data5CopyWithImpl(this._self, this._then);

  final _Data5 _self;
  final $Res Function(_Data5) _then;

/// Create a copy of Data5
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? status = null,Object? title = freezed,Object? description = freezed,Object? category = freezed,Object? progressPercentage = null,}) {
  return _then(_Data5(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
