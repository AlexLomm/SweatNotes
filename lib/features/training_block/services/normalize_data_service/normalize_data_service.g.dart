// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normalize_data_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$normalizeDataServiceHash() =>
    r'8131bc709e5d0852ad49a2114c50fbf4ed02df74';

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

typedef NormalizeDataServiceRef = AutoDisposeProviderRef<NormalizeDataService>;

/// See also [normalizeDataService].
@ProviderFor(normalizeDataService)
const normalizeDataServiceProvider = NormalizeDataServiceFamily();

/// See also [normalizeDataService].
class NormalizeDataServiceFamily extends Family<NormalizeDataService> {
  /// See also [normalizeDataService].
  const NormalizeDataServiceFamily();

  /// See also [normalizeDataService].
  NormalizeDataServiceProvider call(
    String trainingBlockId,
  ) {
    return NormalizeDataServiceProvider(
      trainingBlockId,
    );
  }

  @override
  NormalizeDataServiceProvider getProviderOverride(
    covariant NormalizeDataServiceProvider provider,
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
  String? get name => r'normalizeDataServiceProvider';
}

/// See also [normalizeDataService].
class NormalizeDataServiceProvider
    extends AutoDisposeProvider<NormalizeDataService> {
  /// See also [normalizeDataService].
  NormalizeDataServiceProvider(
    this.trainingBlockId,
  ) : super.internal(
          (ref) => normalizeDataService(
            ref,
            trainingBlockId,
          ),
          from: normalizeDataServiceProvider,
          name: r'normalizeDataServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$normalizeDataServiceHash,
          dependencies: NormalizeDataServiceFamily._dependencies,
          allTransitiveDependencies:
              NormalizeDataServiceFamily._allTransitiveDependencies,
        );

  final String trainingBlockId;

  @override
  bool operator ==(Object other) {
    return other is NormalizeDataServiceProvider &&
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
