// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Race {

 String get raceId; String get name; String get avatarUrl; DateTime get eventStartDate; DateTime get eventEndDate; DateTime get lineupStartDate; DateTime get lineupEndDate; RaceStatus get status;
/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceCopyWith<Race> get copyWith => _$RaceCopyWithImpl<Race>(this as Race, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Race&&(identical(other.raceId, raceId) || other.raceId == raceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.eventStartDate, eventStartDate) || other.eventStartDate == eventStartDate)&&(identical(other.eventEndDate, eventEndDate) || other.eventEndDate == eventEndDate)&&(identical(other.lineupStartDate, lineupStartDate) || other.lineupStartDate == lineupStartDate)&&(identical(other.lineupEndDate, lineupEndDate) || other.lineupEndDate == lineupEndDate)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raceId,name,avatarUrl,eventStartDate,eventEndDate,lineupStartDate,lineupEndDate,status);

@override
String toString() {
  return 'Race(raceId: $raceId, name: $name, avatarUrl: $avatarUrl, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, lineupStartDate: $lineupStartDate, lineupEndDate: $lineupEndDate, status: $status)';
}


}

/// @nodoc
abstract mixin class $RaceCopyWith<$Res>  {
  factory $RaceCopyWith(Race value, $Res Function(Race) _then) = _$RaceCopyWithImpl;
@useResult
$Res call({
 String raceId, String name, String avatarUrl, DateTime eventStartDate, DateTime eventEndDate, DateTime lineupStartDate, DateTime lineupEndDate, RaceStatus status
});




}
/// @nodoc
class _$RaceCopyWithImpl<$Res>
    implements $RaceCopyWith<$Res> {
  _$RaceCopyWithImpl(this._self, this._then);

  final Race _self;
  final $Res Function(Race) _then;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raceId = null,Object? name = null,Object? avatarUrl = null,Object? eventStartDate = null,Object? eventEndDate = null,Object? lineupStartDate = null,Object? lineupEndDate = null,Object? status = null,}) {
  return _then(Race(
raceId: null == raceId ? _self.raceId : raceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,eventStartDate: null == eventStartDate ? _self.eventStartDate : eventStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,eventEndDate: null == eventEndDate ? _self.eventEndDate : eventEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,lineupStartDate: null == lineupStartDate ? _self.lineupStartDate : lineupStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,lineupEndDate: null == lineupEndDate ? _self.lineupEndDate : lineupEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RaceStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [Race].
extension RacePatterns on Race {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
