// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lineup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Lineup {

 String get lineupId; String get teamId; String get raceId; int get totalBudgetSpent; int get racePoints; String get captainDriverId; List<String> get selectedDriverIds; bool get hasSafetyCar; bool get hasVirtualSafetyCar; bool get hasRedFlag; bool get wetTyresUsed; bool get poleToWin; bool get sameTeamOneTwo; int get teamsInTopTenCount; int get retiredCarsCount; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupCopyWith<Lineup> get copyWith => _$LineupCopyWithImpl<Lineup>(this as Lineup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lineup&&(identical(other.lineupId, lineupId) || other.lineupId == lineupId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.raceId, raceId) || other.raceId == raceId)&&(identical(other.totalBudgetSpent, totalBudgetSpent) || other.totalBudgetSpent == totalBudgetSpent)&&(identical(other.racePoints, racePoints) || other.racePoints == racePoints)&&(identical(other.captainDriverId, captainDriverId) || other.captainDriverId == captainDriverId)&&const DeepCollectionEquality().equals(other.selectedDriverIds, selectedDriverIds)&&(identical(other.hasSafetyCar, hasSafetyCar) || other.hasSafetyCar == hasSafetyCar)&&(identical(other.hasVirtualSafetyCar, hasVirtualSafetyCar) || other.hasVirtualSafetyCar == hasVirtualSafetyCar)&&(identical(other.hasRedFlag, hasRedFlag) || other.hasRedFlag == hasRedFlag)&&(identical(other.wetTyresUsed, wetTyresUsed) || other.wetTyresUsed == wetTyresUsed)&&(identical(other.poleToWin, poleToWin) || other.poleToWin == poleToWin)&&(identical(other.sameTeamOneTwo, sameTeamOneTwo) || other.sameTeamOneTwo == sameTeamOneTwo)&&(identical(other.teamsInTopTenCount, teamsInTopTenCount) || other.teamsInTopTenCount == teamsInTopTenCount)&&(identical(other.retiredCarsCount, retiredCarsCount) || other.retiredCarsCount == retiredCarsCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineupId,teamId,raceId,totalBudgetSpent,racePoints,captainDriverId,const DeepCollectionEquality().hash(selectedDriverIds),hasSafetyCar,hasVirtualSafetyCar,hasRedFlag,wetTyresUsed,poleToWin,sameTeamOneTwo,teamsInTopTenCount,retiredCarsCount,createdAt,updatedAt);

@override
String toString() {
  return 'Lineup(lineupId: $lineupId, teamId: $teamId, raceId: $raceId, totalBudgetSpent: $totalBudgetSpent, racePoints: $racePoints, captainDriverId: $captainDriverId, selectedDriverIds: $selectedDriverIds, hasSafetyCar: $hasSafetyCar, hasVirtualSafetyCar: $hasVirtualSafetyCar, hasRedFlag: $hasRedFlag, wetTyresUsed: $wetTyresUsed, poleToWin: $poleToWin, sameTeamOneTwo: $sameTeamOneTwo, teamsInTopTenCount: $teamsInTopTenCount, retiredCarsCount: $retiredCarsCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LineupCopyWith<$Res>  {
  factory $LineupCopyWith(Lineup value, $Res Function(Lineup) _then) = _$LineupCopyWithImpl;
@useResult
$Res call({
 String lineupId, String teamId, String raceId, int totalBudgetSpent, int racePoints, String captainDriverId, List<String> selectedDriverIds, bool hasSafetyCar, bool hasVirtualSafetyCar, bool hasRedFlag, bool wetTyresUsed, bool poleToWin, bool sameTeamOneTwo, int teamsInTopTenCount, int retiredCarsCount, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$LineupCopyWithImpl<$Res>
    implements $LineupCopyWith<$Res> {
  _$LineupCopyWithImpl(this._self, this._then);

  final Lineup _self;
  final $Res Function(Lineup) _then;

/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineupId = null,Object? teamId = null,Object? raceId = null,Object? totalBudgetSpent = null,Object? racePoints = null,Object? captainDriverId = null,Object? selectedDriverIds = null,Object? hasSafetyCar = null,Object? hasVirtualSafetyCar = null,Object? hasRedFlag = null,Object? wetTyresUsed = null,Object? poleToWin = null,Object? sameTeamOneTwo = null,Object? teamsInTopTenCount = null,Object? retiredCarsCount = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(Lineup(
lineupId: null == lineupId ? _self.lineupId : lineupId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,raceId: null == raceId ? _self.raceId : raceId // ignore: cast_nullable_to_non_nullable
as String,totalBudgetSpent: null == totalBudgetSpent ? _self.totalBudgetSpent : totalBudgetSpent // ignore: cast_nullable_to_non_nullable
as int,racePoints: null == racePoints ? _self.racePoints : racePoints // ignore: cast_nullable_to_non_nullable
as int,captainDriverId: null == captainDriverId ? _self.captainDriverId : captainDriverId // ignore: cast_nullable_to_non_nullable
as String,selectedDriverIds: null == selectedDriverIds ? _self.selectedDriverIds : selectedDriverIds // ignore: cast_nullable_to_non_nullable
as List<String>,hasSafetyCar: null == hasSafetyCar ? _self.hasSafetyCar : hasSafetyCar // ignore: cast_nullable_to_non_nullable
as bool,hasVirtualSafetyCar: null == hasVirtualSafetyCar ? _self.hasVirtualSafetyCar : hasVirtualSafetyCar // ignore: cast_nullable_to_non_nullable
as bool,hasRedFlag: null == hasRedFlag ? _self.hasRedFlag : hasRedFlag // ignore: cast_nullable_to_non_nullable
as bool,wetTyresUsed: null == wetTyresUsed ? _self.wetTyresUsed : wetTyresUsed // ignore: cast_nullable_to_non_nullable
as bool,poleToWin: null == poleToWin ? _self.poleToWin : poleToWin // ignore: cast_nullable_to_non_nullable
as bool,sameTeamOneTwo: null == sameTeamOneTwo ? _self.sameTeamOneTwo : sameTeamOneTwo // ignore: cast_nullable_to_non_nullable
as bool,teamsInTopTenCount: null == teamsInTopTenCount ? _self.teamsInTopTenCount : teamsInTopTenCount // ignore: cast_nullable_to_non_nullable
as int,retiredCarsCount: null == retiredCarsCount ? _self.retiredCarsCount : retiredCarsCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Lineup].
extension LineupPatterns on Lineup {
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
