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

 String get raceId; String get raceName; int get openF1MeetingKey; String get circuitImage; DateTime get dateStart; DateTime get dateEnd; String get countryName; String get countryFlag; String get circuitType; DateTime get dateLineupOpen; DateTime get dateLineupClose;
/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceCopyWith<Race> get copyWith => _$RaceCopyWithImpl<Race>(this as Race, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Race&&(identical(other.raceId, raceId) || other.raceId == raceId)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.openF1MeetingKey, openF1MeetingKey) || other.openF1MeetingKey == openF1MeetingKey)&&(identical(other.circuitImage, circuitImage) || other.circuitImage == circuitImage)&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.countryFlag, countryFlag) || other.countryFlag == countryFlag)&&(identical(other.circuitType, circuitType) || other.circuitType == circuitType)&&(identical(other.dateLineupOpen, dateLineupOpen) || other.dateLineupOpen == dateLineupOpen)&&(identical(other.dateLineupClose, dateLineupClose) || other.dateLineupClose == dateLineupClose));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raceId,raceName,openF1MeetingKey,circuitImage,dateStart,dateEnd,countryName,countryFlag,circuitType,dateLineupOpen,dateLineupClose);

@override
String toString() {
  return 'Race(raceId: $raceId, raceName: $raceName, openF1MeetingKey: $openF1MeetingKey, circuitImage: $circuitImage, dateStart: $dateStart, dateEnd: $dateEnd, countryName: $countryName, countryFlag: $countryFlag, circuitType: $circuitType, dateLineupOpen: $dateLineupOpen, dateLineupClose: $dateLineupClose)';
}


}

/// @nodoc
abstract mixin class $RaceCopyWith<$Res>  {
  factory $RaceCopyWith(Race value, $Res Function(Race) _then) = _$RaceCopyWithImpl;
@useResult
$Res call({
 String raceId, String raceName, int openF1MeetingKey, String circuitImage, DateTime dateStart, DateTime dateEnd, String countryName, String countryFlag, String circuitType, DateTime dateLineupOpen, DateTime dateLineupClose
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
@pragma('vm:prefer-inline') @override $Res call({Object? raceId = null,Object? raceName = null,Object? openF1MeetingKey = null,Object? circuitImage = null,Object? dateStart = null,Object? dateEnd = null,Object? countryName = null,Object? countryFlag = null,Object? circuitType = null,Object? dateLineupOpen = null,Object? dateLineupClose = null,}) {
  return _then(Race(
raceId: null == raceId ? _self.raceId : raceId // ignore: cast_nullable_to_non_nullable
as String,raceName: null == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String,openF1MeetingKey: null == openF1MeetingKey ? _self.openF1MeetingKey : openF1MeetingKey // ignore: cast_nullable_to_non_nullable
as int,circuitImage: null == circuitImage ? _self.circuitImage : circuitImage // ignore: cast_nullable_to_non_nullable
as String,dateStart: null == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,countryName: null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String,countryFlag: null == countryFlag ? _self.countryFlag : countryFlag // ignore: cast_nullable_to_non_nullable
as String,circuitType: null == circuitType ? _self.circuitType : circuitType // ignore: cast_nullable_to_non_nullable
as String,dateLineupOpen: null == dateLineupOpen ? _self.dateLineupOpen : dateLineupOpen // ignore: cast_nullable_to_non_nullable
as DateTime,dateLineupClose: null == dateLineupClose ? _self.dateLineupClose : dateLineupClose // ignore: cast_nullable_to_non_nullable
as DateTime,
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
