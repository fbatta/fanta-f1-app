// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverSummary {

 String get driverId; String get driverAcronym; String get driverName; int get driverNumber; List<String> get summaryParagraphs;
/// Create a copy of DriverSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverSummaryCopyWith<DriverSummary> get copyWith => _$DriverSummaryCopyWithImpl<DriverSummary>(this as DriverSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverSummary&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverAcronym, driverAcronym) || other.driverAcronym == driverAcronym)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&const DeepCollectionEquality().equals(other.summaryParagraphs, summaryParagraphs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driverId,driverAcronym,driverName,driverNumber,const DeepCollectionEquality().hash(summaryParagraphs));

@override
String toString() {
  return 'DriverSummary(driverId: $driverId, driverAcronym: $driverAcronym, driverName: $driverName, driverNumber: $driverNumber, summaryParagraphs: $summaryParagraphs)';
}


}

/// @nodoc
abstract mixin class $DriverSummaryCopyWith<$Res>  {
  factory $DriverSummaryCopyWith(DriverSummary value, $Res Function(DriverSummary) _then) = _$DriverSummaryCopyWithImpl;
@useResult
$Res call({
 String driverId, String driverAcronym, String driverName, int driverNumber, List<String> summaryParagraphs
});




}
/// @nodoc
class _$DriverSummaryCopyWithImpl<$Res>
    implements $DriverSummaryCopyWith<$Res> {
  _$DriverSummaryCopyWithImpl(this._self, this._then);

  final DriverSummary _self;
  final $Res Function(DriverSummary) _then;

/// Create a copy of DriverSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driverId = null,Object? driverAcronym = null,Object? driverName = null,Object? driverNumber = null,Object? summaryParagraphs = null,}) {
  return _then(DriverSummary(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverAcronym: null == driverAcronym ? _self.driverAcronym : driverAcronym // ignore: cast_nullable_to_non_nullable
as String,driverName: null == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String,driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as int,summaryParagraphs: null == summaryParagraphs ? _self.summaryParagraphs : summaryParagraphs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverSummary].
extension DriverSummaryPatterns on DriverSummary {
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
