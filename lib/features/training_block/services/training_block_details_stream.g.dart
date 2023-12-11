// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block_details_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingBlockDetailsStreamHash() =>
    r'522c31ff4b82a5a5d6d61985f63efeb82ae85aea';

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
    String trainingBlockId, {
    required bool includeArchived,
  }) {
    return TrainingBlockDetailsStreamProvider(
      trainingBlockId,
      includeArchived: includeArchived,
    );
  }

  @override
  TrainingBlockDetailsStreamProvider getProviderOverride(
    covariant TrainingBlockDetailsStreamProvider provider,
  ) {
    return call(
      provider.trainingBlockId,
      includeArchived: provider.includeArchived,
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
    String trainingBlockId, {
    required bool includeArchived,
  }) : this._internal(
          (ref) => trainingBlockDetailsStream(
            ref as TrainingBlockDetailsStreamRef,
            trainingBlockId,
            includeArchived: includeArchived,
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
          trainingBlockId: trainingBlockId,
          includeArchived: includeArchived,
        );

  TrainingBlockDetailsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.trainingBlockId,
    required this.includeArchived,
  }) : super.internal();

  final String trainingBlockId;
  final bool includeArchived;

  @override
  Override overrideWith(
    Stream<TrainingBlockClient?> Function(
            TrainingBlockDetailsStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TrainingBlockDetailsStreamProvider._internal(
        (ref) => create(ref as TrainingBlockDetailsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        trainingBlockId: trainingBlockId,
        includeArchived: includeArchived,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<TrainingBlockClient?> createElement() {
    return _TrainingBlockDetailsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrainingBlockDetailsStreamProvider &&
        other.trainingBlockId == trainingBlockId &&
        other.includeArchived == includeArchived;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trainingBlockId.hashCode);
    hash = _SystemHash.combine(hash, includeArchived.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TrainingBlockDetailsStreamRef
    on AutoDisposeStreamProviderRef<TrainingBlockClient?> {
  /// The parameter `trainingBlockId` of this provider.
  String get trainingBlockId;

  /// The parameter `includeArchived` of this provider.
  bool get includeArchived;
}

class _TrainingBlockDetailsStreamProviderElement
    extends AutoDisposeStreamProviderElement<TrainingBlockClient?>
    with TrainingBlockDetailsStreamRef {
  _TrainingBlockDetailsStreamProviderElement(super.provider);

  @override
  String get trainingBlockId =>
      (origin as TrainingBlockDetailsStreamProvider).trainingBlockId;
  @override
  bool get includeArchived =>
      (origin as TrainingBlockDetailsStreamProvider).includeArchived;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
