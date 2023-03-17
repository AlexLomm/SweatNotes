// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normalize_data_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$normalizedDataServiceHash() =>
    r'f2f1c150bcf9cea7a495a8bbb6c39b40a9012a23';

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

typedef NormalizedDataServiceRef
    = AutoDisposeStreamProviderRef<TrainingBlockClient?>;

/// See also [normalizedDataService].
@ProviderFor(normalizedDataService)
const normalizedDataServiceProvider = NormalizedDataServiceFamily();

/// See also [normalizedDataService].
class NormalizedDataServiceFamily
    extends Family<AsyncValue<TrainingBlockClient?>> {
  /// See also [normalizedDataService].
  const NormalizedDataServiceFamily();

  /// See also [normalizedDataService].
  NormalizedDataServiceProvider call(
    String trainingBlockId,
  ) {
    return NormalizedDataServiceProvider(
      trainingBlockId,
    );
  }

  @override
  NormalizedDataServiceProvider getProviderOverride(
    covariant NormalizedDataServiceProvider provider,
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
  String? get name => r'normalizedDataServiceProvider';
}

/// See also [normalizedDataService].
class NormalizedDataServiceProvider
    extends AutoDisposeStreamProvider<TrainingBlockClient?> {
  /// See also [normalizedDataService].
  NormalizedDataServiceProvider(
    this.trainingBlockId,
  ) : super.internal(
          (ref) => normalizedDataService(
            ref,
            trainingBlockId,
          ),
          from: normalizedDataServiceProvider,
          name: r'normalizedDataServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$normalizedDataServiceHash,
          dependencies: NormalizedDataServiceFamily._dependencies,
          allTransitiveDependencies:
              NormalizedDataServiceFamily._allTransitiveDependencies,
        );

  final String trainingBlockId;

  @override
  bool operator ==(Object other) {
    return other is NormalizedDataServiceProvider &&
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
