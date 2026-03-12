// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lineup_driver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LineupDriver {

 String? get driverId; int get driverNumber; String get driverAcronym; double? get driverCost;
/// Create a copy of LineupDriver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupDriverCopyWith<LineupDriver> get copyWith => _$LineupDriverCopyWithImpl<LineupDriver>(this as LineupDriver, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineupDriver&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&(identical(other.driverAcronym, driverAcronym) || other.driverAcronym == driverAcronym)&&(identical(other.driverCost, driverCost) || other.driverCost == driverCost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driverId,driverNumber,driverAcronym,driverCost);

@override
String toString() {
  return 'LineupDriver(driverId: $driverId, driverNumber: $driverNumber, driverAcronym: $driverAcronym, driverCost: $driverCost)';
}


}

/// @nodoc
abstract mixin class $LineupDriverCopyWith<$Res>  {
  factory $LineupDriverCopyWith(LineupDriver value, $Res Function(LineupDriver) _then) = _$LineupDriverCopyWithImpl;
@useResult
$Res call({
 int driverNumber, String driverAcronym, double? driverCost, String? driverId
});




}
/// @nodoc
class _$LineupDriverCopyWithImpl<$Res>
    implements $LineupDriverCopyWith<$Res> {
  _$LineupDriverCopyWithImpl(this._self, this._then);

  final LineupDriver _self;
  final $Res Function(LineupDriver) _then;

/// Create a copy of LineupDriver
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driverNumber = null,Object? driverAcronym = null,Object? driverCost = freezed,Object? driverId = freezed,}) {
  return _then(LineupDriver(
driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as int,driverAcronym: null == driverAcronym ? _self.driverAcronym : driverAcronym // ignore: cast_nullable_to_non_nullable
as String,driverCost: freezed == driverCost ? _self.driverCost : driverCost // ignore: cast_nullable_to_non_nullable
as double?,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LineupDriver].
extension LineupDriverPatterns on LineupDriver {
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
