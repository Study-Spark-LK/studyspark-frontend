// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profiles_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfilesRequestBody {

 String get name; List<Qna> get qna;
/// Create a copy of ProfilesRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilesRequestBodyCopyWith<ProfilesRequestBody> get copyWith => _$ProfilesRequestBodyCopyWithImpl<ProfilesRequestBody>(this as ProfilesRequestBody, _$identity);

  /// Serializes this ProfilesRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilesRequestBody&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.qna, qna));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(qna));

@override
String toString() {
  return 'ProfilesRequestBody(name: $name, qna: $qna)';
}


}

/// @nodoc
abstract mixin class $ProfilesRequestBodyCopyWith<$Res>  {
  factory $ProfilesRequestBodyCopyWith(ProfilesRequestBody value, $Res Function(ProfilesRequestBody) _then) = _$ProfilesRequestBodyCopyWithImpl;
@useResult
$Res call({
 String name, List<Qna> qna
});




}
/// @nodoc
class _$ProfilesRequestBodyCopyWithImpl<$Res>
    implements $ProfilesRequestBodyCopyWith<$Res> {
  _$ProfilesRequestBodyCopyWithImpl(this._self, this._then);

  final ProfilesRequestBody _self;
  final $Res Function(ProfilesRequestBody) _then;

/// Create a copy of ProfilesRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? qna = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,qna: null == qna ? _self.qna : qna // ignore: cast_nullable_to_non_nullable
as List<Qna>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfilesRequestBody].
extension ProfilesRequestBodyPatterns on ProfilesRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilesRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilesRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilesRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _ProfilesRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilesRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilesRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<Qna> qna)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilesRequestBody() when $default != null:
return $default(_that.name,_that.qna);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<Qna> qna)  $default,) {final _that = this;
switch (_that) {
case _ProfilesRequestBody():
return $default(_that.name,_that.qna);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<Qna> qna)?  $default,) {final _that = this;
switch (_that) {
case _ProfilesRequestBody() when $default != null:
return $default(_that.name,_that.qna);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfilesRequestBody implements ProfilesRequestBody {
  const _ProfilesRequestBody({required this.name, required final  List<Qna> qna}): _qna = qna;
  factory _ProfilesRequestBody.fromJson(Map<String, dynamic> json) => _$ProfilesRequestBodyFromJson(json);

@override final  String name;
 final  List<Qna> _qna;
@override List<Qna> get qna {
  if (_qna is EqualUnmodifiableListView) return _qna;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qna);
}


/// Create a copy of ProfilesRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilesRequestBodyCopyWith<_ProfilesRequestBody> get copyWith => __$ProfilesRequestBodyCopyWithImpl<_ProfilesRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfilesRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilesRequestBody&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._qna, _qna));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_qna));

@override
String toString() {
  return 'ProfilesRequestBody(name: $name, qna: $qna)';
}


}

/// @nodoc
abstract mixin class _$ProfilesRequestBodyCopyWith<$Res> implements $ProfilesRequestBodyCopyWith<$Res> {
  factory _$ProfilesRequestBodyCopyWith(_ProfilesRequestBody value, $Res Function(_ProfilesRequestBody) _then) = __$ProfilesRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String name, List<Qna> qna
});




}
/// @nodoc
class __$ProfilesRequestBodyCopyWithImpl<$Res>
    implements _$ProfilesRequestBodyCopyWith<$Res> {
  __$ProfilesRequestBodyCopyWithImpl(this._self, this._then);

  final _ProfilesRequestBody _self;
  final $Res Function(_ProfilesRequestBody) _then;

/// Create a copy of ProfilesRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? qna = null,}) {
  return _then(_ProfilesRequestBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,qna: null == qna ? _self._qna : qna // ignore: cast_nullable_to_non_nullable
as List<Qna>,
  ));
}


}

// dart format on
