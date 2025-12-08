// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverScore {

 String get raceId; String get driverId; int get points; int get startPosition; int get finishPosition; bool get isDnf; bool get isDns; bool get hasPenalties; bool get reachedQ1; bool get reachedQ2; bool get reachedQ3; bool get beatTeammateInQuali; bool get beatTeammateInRace; DateTime? get calculatedAt;
/// Create a copy of DriverScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverScoreCopyWith<DriverScore> get copyWith => _$DriverScoreCopyWithImpl<DriverScore>(this as DriverScore, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverScore&&(identical(other.raceId, raceId) || other.raceId == raceId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.points, points) || other.points == points)&&(identical(other.startPosition, startPosition) || other.startPosition == startPosition)&&(identical(other.finishPosition, finishPosition) || other.finishPosition == finishPosition)&&(identical(other.isDnf, isDnf) || other.isDnf == isDnf)&&(identical(other.isDns, isDns) || other.isDns == isDns)&&(identical(other.hasPenalties, hasPenalties) || other.hasPenalties == hasPenalties)&&(identical(other.reachedQ1, reachedQ1) || other.reachedQ1 == reachedQ1)&&(identical(other.reachedQ2, reachedQ2) || other.reachedQ2 == reachedQ2)&&(identical(other.reachedQ3, reachedQ3) || other.reachedQ3 == reachedQ3)&&(identical(other.beatTeammateInQuali, beatTeammateInQuali) || other.beatTeammateInQuali == beatTeammateInQuali)&&(identical(other.beatTeammateInRace, beatTeammateInRace) || other.beatTeammateInRace == beatTeammateInRace)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raceId,driverId,points,startPosition,finishPosition,isDnf,isDns,hasPenalties,reachedQ1,reachedQ2,reachedQ3,beatTeammateInQuali,beatTeammateInRace,calculatedAt);

@override
String toString() {
  return 'DriverScore(raceId: $raceId, driverId: $driverId, points: $points, startPosition: $startPosition, finishPosition: $finishPosition, isDnf: $isDnf, isDns: $isDns, hasPenalties: $hasPenalties, reachedQ1: $reachedQ1, reachedQ2: $reachedQ2, reachedQ3: $reachedQ3, beatTeammateInQuali: $beatTeammateInQuali, beatTeammateInRace: $beatTeammateInRace, calculatedAt: $calculatedAt)';
}


}

/// @nodoc
abstract mixin class $DriverScoreCopyWith<$Res>  {
  factory $DriverScoreCopyWith(DriverScore value, $Res Function(DriverScore) _then) = _$DriverScoreCopyWithImpl;
@useResult
$Res call({
 String raceId, String driverId, int points, int startPosition, int finishPosition, bool isDnf, bool isDns, bool hasPenalties, bool reachedQ1, bool reachedQ2, bool reachedQ3, bool beatTeammateInQuali, bool beatTeammateInRace, DateTime? calculatedAt
});




}
/// @nodoc
class _$DriverScoreCopyWithImpl<$Res>
    implements $DriverScoreCopyWith<$Res> {
  _$DriverScoreCopyWithImpl(this._self, this._then);

  final DriverScore _self;
  final $Res Function(DriverScore) _then;

/// Create a copy of DriverScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raceId = null,Object? driverId = null,Object? points = null,Object? startPosition = null,Object? finishPosition = null,Object? isDnf = null,Object? isDns = null,Object? hasPenalties = null,Object? reachedQ1 = null,Object? reachedQ2 = null,Object? reachedQ3 = null,Object? beatTeammateInQuali = null,Object? beatTeammateInRace = null,Object? calculatedAt = freezed,}) {
  return _then(DriverScore(
raceId: null == raceId ? _self.raceId : raceId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,startPosition: null == startPosition ? _self.startPosition : startPosition // ignore: cast_nullable_to_non_nullable
as int,finishPosition: null == finishPosition ? _self.finishPosition : finishPosition // ignore: cast_nullable_to_non_nullable
as int,isDnf: null == isDnf ? _self.isDnf : isDnf // ignore: cast_nullable_to_non_nullable
as bool,isDns: null == isDns ? _self.isDns : isDns // ignore: cast_nullable_to_non_nullable
as bool,hasPenalties: null == hasPenalties ? _self.hasPenalties : hasPenalties // ignore: cast_nullable_to_non_nullable
as bool,reachedQ1: null == reachedQ1 ? _self.reachedQ1 : reachedQ1 // ignore: cast_nullable_to_non_nullable
as bool,reachedQ2: null == reachedQ2 ? _self.reachedQ2 : reachedQ2 // ignore: cast_nullable_to_non_nullable
as bool,reachedQ3: null == reachedQ3 ? _self.reachedQ3 : reachedQ3 // ignore: cast_nullable_to_non_nullable
as bool,beatTeammateInQuali: null == beatTeammateInQuali ? _self.beatTeammateInQuali : beatTeammateInQuali // ignore: cast_nullable_to_non_nullable
as bool,beatTeammateInRace: null == beatTeammateInRace ? _self.beatTeammateInRace : beatTeammateInRace // ignore: cast_nullable_to_non_nullable
as bool,calculatedAt: freezed == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverScore].
extension DriverScorePatterns on DriverScore {
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
