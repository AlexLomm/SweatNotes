// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block_store_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingBlockStoreServiceHash() =>
    r'1439d4b91730fac95fa074da025eebe6f0486aa4';

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

abstract class _$TrainingBlockStoreService
    extends BuildlessAutoDisposeAsyncNotifier<List<ExerciseDayClient>> {
  late final String trainingBlockId;

  FutureOr<List<ExerciseDayClient>> build(
    String trainingBlockId,
  );
}

/// See also [TrainingBlockStoreService].
@ProviderFor(TrainingBlockStoreService)
const trainingBlockStoreServiceProvider = TrainingBlockStoreServiceFamily();

/// See also [TrainingBlockStoreService].
class TrainingBlockStoreServiceFamily
    extends Family<AsyncValue<List<ExerciseDayClient>>> {
  /// See also [TrainingBlockStoreService].
  const TrainingBlockStoreServiceFamily();

  /// See also [TrainingBlockStoreService].
  TrainingBlockStoreServiceProvider call(
    String trainingBlockId,
  ) {
    return TrainingBlockStoreServiceProvider(
      trainingBlockId,
    );
  }

  @override
  TrainingBlockStoreServiceProvider getProviderOverride(
    covariant TrainingBlockStoreServiceProvider provider,
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
  String? get name => r'trainingBlockStoreServiceProvider';
}

/// See also [TrainingBlockStoreService].
class TrainingBlockStoreServiceProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TrainingBlockStoreService,
        List<ExerciseDayClient>> {
  /// See also [TrainingBlockStoreService].
  TrainingBlockStoreServiceProvider(
    this.trainingBlockId,
  ) : super.internal(
          () => TrainingBlockStoreService()..trainingBlockId = trainingBlockId,
          from: trainingBlockStoreServiceProvider,
          name: r'trainingBlockStoreServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trainingBlockStoreServiceHash,
          dependencies: TrainingBlockStoreServiceFamily._dependencies,
          allTransitiveDependencies:
              TrainingBlockStoreServiceFamily._allTransitiveDependencies,
        );

  final String trainingBlockId;

  @override
  bool operator ==(Object other) {
    return other is TrainingBlockStoreServiceProvider &&
        other.trainingBlockId == trainingBlockId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trainingBlockId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<ExerciseDayClient>> runNotifierBuild(
    covariant TrainingBlockStoreService notifier,
  ) {
    return notifier.build(
      trainingBlockId,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
