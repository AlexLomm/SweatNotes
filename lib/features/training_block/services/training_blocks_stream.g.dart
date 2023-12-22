// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_blocks_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingBlocksStreamHash() =>
    r'a385ba6c88bc4d7a6654d5bff27e05bb02880524';

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

/// See also [trainingBlocksStream].
@ProviderFor(trainingBlocksStream)
const trainingBlocksStreamProvider = TrainingBlocksStreamFamily();

/// See also [trainingBlocksStream].
class TrainingBlocksStreamFamily
    extends Family<AsyncValue<List<TrainingBlockClient>>> {
  /// See also [trainingBlocksStream].
  const TrainingBlocksStreamFamily();

  /// See also [trainingBlocksStream].
  TrainingBlocksStreamProvider call({
    required bool includeArchived,
  }) {
    return TrainingBlocksStreamProvider(
      includeArchived: includeArchived,
    );
  }

  @override
  TrainingBlocksStreamProvider getProviderOverride(
    covariant TrainingBlocksStreamProvider provider,
  ) {
    return call(
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
  String? get name => r'trainingBlocksStreamProvider';
}

/// See also [trainingBlocksStream].
class TrainingBlocksStreamProvider
    extends AutoDisposeStreamProvider<List<TrainingBlockClient>> {
  /// See also [trainingBlocksStream].
  TrainingBlocksStreamProvider({
    required bool includeArchived,
  }) : this._internal(
          (ref) => trainingBlocksStream(
            ref as TrainingBlocksStreamRef,
            includeArchived: includeArchived,
          ),
          from: trainingBlocksStreamProvider,
          name: r'trainingBlocksStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trainingBlocksStreamHash,
          dependencies: TrainingBlocksStreamFamily._dependencies,
          allTransitiveDependencies:
              TrainingBlocksStreamFamily._allTransitiveDependencies,
          includeArchived: includeArchived,
        );

  TrainingBlocksStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.includeArchived,
  }) : super.internal();

  final bool includeArchived;

  @override
  Override overrideWith(
    Stream<List<TrainingBlockClient>> Function(TrainingBlocksStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TrainingBlocksStreamProvider._internal(
        (ref) => create(ref as TrainingBlocksStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        includeArchived: includeArchived,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TrainingBlockClient>> createElement() {
    return _TrainingBlocksStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrainingBlocksStreamProvider &&
        other.includeArchived == includeArchived;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, includeArchived.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TrainingBlocksStreamRef
    on AutoDisposeStreamProviderRef<List<TrainingBlockClient>> {
  /// The parameter `includeArchived` of this provider.
  bool get includeArchived;
}

class _TrainingBlocksStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<TrainingBlockClient>>
    with TrainingBlocksStreamRef {
  _TrainingBlocksStreamProviderElement(super.provider);

  @override
  bool get includeArchived =>
      (origin as TrainingBlocksStreamProvider).includeArchived;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
