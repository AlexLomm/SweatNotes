// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block_details_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingBlockDetailsStreamHash() =>
    r'29838532389dc48556a47e2865a2d9aeef9aacfb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef TrainingBlockDetailsStreamRef
    = AutoDisposeStreamProviderRef<TrainingBlockClient?>;

/// See also [trainingBlockDetailsStream].
@ProviderFor(trainingBlockDetailsStream)
const trainingBlockDetailsStreamProvider = TrainingBlockDetailsStreamFamily();

/// See also [trainingBlockDetailsStream].
class TrainingBlockDetailsStreamFamily
    extends Family<AsyncValue<TrainingBlockClient?>> {
  /// See also [trainingBlockDetailsStream].
  const TrainingBlockDetailsStreamFamily();

  /// See also [trainingBlockDetailsStream].
  TrainingBlockDetailsStreamProvider call(
    String trainingBlockId,
  ) {
    return TrainingBlockDetailsStreamProvider(
      trainingBlockId,
    );
  }

  @override
  TrainingBlockDetailsStreamProvider getProviderOverride(
    covariant TrainingBlockDetailsStreamProvider provider,
  ) {
    return call(
      provider.trainingBlockId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'trainingBlockDetailsStreamProvider';
}

/// See also [trainingBlockDetailsStream].
class TrainingBlockDetailsStreamProvider
    extends AutoDisposeStreamProvider<TrainingBlockClient?> {
  /// See also [trainingBlockDetailsStream].
  TrainingBlockDetailsStreamProvider(
    this.trainingBlockId,
  ) : super.internal(
          (ref) => trainingBlockDetailsStream(
            ref,
            trainingBlockId,
          ),
          from: trainingBlockDetailsStreamProvider,
          name: r'trainingBlockDetailsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trainingBlockDetailsStreamHash,
          dependencies: TrainingBlockDetailsStreamFamily._dependencies,
          allTransitiveDependencies:
              TrainingBlockDetailsStreamFamily._allTransitiveDependencies,
        );

  final String trainingBlockId;

  @override
  bool operator ==(Object other) {
    return other is TrainingBlockDetailsStreamProvider &&
        other.trainingBlockId == trainingBlockId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trainingBlockId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
