// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data7.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Data7 {

 String get id; String get profileId; Status get status; String get title; String get description; String get category; num get progressPercentage; String get originalFileId; List<GeneratedFiles> get generatedFiles;
/// Create a copy of Data7
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Data7CopyWith<Data7> get copyWith => _$Data7CopyWithImpl<Data7>(this as Data7, _$identity);

  /// Serializes this Data7 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data7&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.originalFileId, originalFileId) || other.originalFileId == originalFileId)&&const DeepCollectionEquality().equals(other.generatedFiles, generatedFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,status,title,description,category,progressPercentage,originalFileId,const DeepCollectionEquality().hash(generatedFiles));

@override
String toString() {
  return 'Data7(id: $id, profileId: $profileId, status: $status, title: $title, description: $description, category: $category, progressPercentage: $progressPercentage, originalFileId: $originalFileId, generatedFiles: $generatedFiles)';
}


}

/// @nodoc
abstract mixin class $Data7CopyWith<$Res>  {
  factory $Data7CopyWith(Data7 value, $Res Function(Data7) _then) = _$Data7CopyWithImpl;
@useResult
$Res call({
 String id, String profileId, Status status, String title, String description, String category, num progressPercentage, String originalFileId, List<GeneratedFiles> generatedFiles
});




}
/// @nodoc
class _$Data7CopyWithImpl<$Res>
    implements $Data7CopyWith<$Res> {
  _$Data7CopyWithImpl(this._self, this._then);

  final Data7 _self;
  final $Res Function(Data7) _then;

/// Create a copy of Data7
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? status = null,Object? title = null,Object? description = null,Object? category = null,Object? progressPercentage = null,Object? originalFileId = null,Object? generatedFiles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as num,originalFileId: null == originalFileId ? _self.originalFileId : originalFileId // ignore: cast_nullable_to_non_nullable
as String,generatedFiles: null == generatedFiles ? _self.generatedFiles : generatedFiles // ignore: cast_nullable_to_non_nullable
as List<GeneratedFiles>,
  ));
}

}


/// Adds pattern-matching-related methods to [Data7].
extension Data7Patterns on Data7 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data7 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data7() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data7 value)  $default,){
final _that = this;
switch (_that) {
case _Data7():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data7 value)?  $default,){
final _that = this;
switch (_that) {
case _Data7() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  Status status,  String title,  String description,  String category,  num progressPercentage,  String originalFileId,  List<GeneratedFiles> generatedFiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data7() when $default != null:
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage,_that.originalFileId,_that.generatedFiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  Status status,  String title,  String description,  String category,  num progressPercentage,  String originalFileId,  List<GeneratedFiles> generatedFiles)  $default,) {final _that = this;
switch (_that) {
case _Data7():
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage,_that.originalFileId,_that.generatedFiles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  Status status,  String title,  String description,  String category,  num progressPercentage,  String originalFileId,  List<GeneratedFiles> generatedFiles)?  $default,) {final _that = this;
switch (_that) {
case _Data7() when $default != null:
return $default(_that.id,_that.profileId,_that.status,_that.title,_that.description,_that.category,_that.progressPercentage,_that.originalFileId,_that.generatedFiles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data7 implements Data7 {
  const _Data7({required this.id, required this.profileId, required this.status, required this.title, required this.description, required this.category, required this.progressPercentage, required this.originalFileId, required final  List<GeneratedFiles> generatedFiles}): _generatedFiles = generatedFiles;
  factory _Data7.fromJson(Map<String, dynamic> json) => _$Data7FromJson(json);

@override final  String id;
@override final  String profileId;
@override final  Status status;
@override final  String title;
@override final  String description;
@override final  String category;
@override final  num progressPercentage;
@override final  String originalFileId;
 final  List<GeneratedFiles> _generatedFiles;
@override List<GeneratedFiles> get generatedFiles {
  if (_generatedFiles is EqualUnmodifiableListView) return _generatedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_generatedFiles);
}


/// Create a copy of Data7
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Data7CopyWith<_Data7> get copyWith => __$Data7CopyWithImpl<_Data7>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Data7ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data7&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.originalFileId, originalFileId) || other.originalFileId == originalFileId)&&const DeepCollectionEquality().equals(other._generatedFiles, _generatedFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,status,title,description,category,progressPercentage,originalFileId,const DeepCollectionEquality().hash(_generatedFiles));

@override
String toString() {
  return 'Data7(id: $id, profileId: $profileId, status: $status, title: $title, description: $description, category: $category, progressPercentage: $progressPercentage, originalFileId: $originalFileId, generatedFiles: $generatedFiles)';
}


}

/// @nodoc
abstract mixin class _$Data7CopyWith<$Res> implements $Data7CopyWith<$Res> {
  factory _$Data7CopyWith(_Data7 value, $Res Function(_Data7) _then) = __$Data7CopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, Status status, String title, String description, String category, num progressPercentage, String originalFileId, List<GeneratedFiles> generatedFiles
});




}
/// @nodoc
class __$Data7CopyWithImpl<$Res>
    implements _$Data7CopyWith<$Res> {
  __$Data7CopyWithImpl(this._self, this._then);

  final _Data7 _self;
  final $Res Function(_Data7) _then;

/// Create a copy of Data7
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? status = null,Object? title = null,Object? description = null,Object? category = null,Object? progressPercentage = null,Object? originalFileId = null,Object? generatedFiles = null,}) {
  return _then(_Data7(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as num,originalFileId: null == originalFileId ? _self.originalFileId : originalFileId // ignore: cast_nullable_to_non_nullable
as String,generatedFiles: null == generatedFiles ? _self._generatedFiles : generatedFiles // ignore: cast_nullable_to_non_nullable
as List<GeneratedFiles>,
  ));
}


}

// dart format on
