import 'dart:async';

import 'package:flutter/material.dart';

import '../model/tutor_tooltip_model.dart';

class TutorController {
  TutorTooltipModel? _currentModel;
  final List<TutorTooltipModel> _queue = [];
  final List<TutorTooltipModel> _allWidgets = [];

  bool get hasTooltipsInQueue => _queue.isNotEmpty;

  bool get isInProgress => _currentModel != null;

  final isReady = ValueNotifier<bool>(false);

  final StreamController<TutorTooltipModel?> _widgetsPlayController =
      StreamController.broadcast();

  Stream<TutorTooltipModel?> get widgetsPlayStream =>
      _widgetsPlayController.stream..listen((event) => _currentModel = event);

  VoidCallback? _onDoneCallback;

  void next() {
    _currentModel?.onClose?.call();

    if (_queue.isEmpty) {
      _widgetsPlayController.sink.add(null);
      _onDoneCallback?.call();

      _updateIsReady();

      return;
    }

    final model = _queue.removeAt(0);

    _widgetsPlayController.sink.add(model);

    _updateIsReady();
  }

  void dismiss() {
    _currentModel?.onClose?.call();

    _queue.clear();
    _widgetsPlayController.sink.add(null);
    _onDoneCallback?.call();

    _updateIsReady();
  }

  void unregister(TutorTooltipModel model) {
    _remove(_allWidgets, model);
    _remove(_queue, model);

    _updateIsReady();
  }

  void register(TutorTooltipModel model) {
    _addReplace(_allWidgets, model);

    if (model.active) {
      _addReplace(_queue, model);
    } else {
      _remove(_queue, model);
    }

    _updateIsReady();
  }

  void _remove(List<TutorTooltipModel> widgets, TutorTooltipModel model) {
    final index = _getIndexOf(widgets, model.order);

    if (index < 0) return;

    widgets.removeAt(index);
  }

  void _addReplace(
    List<TutorTooltipModel> widgets,
    TutorTooltipModel model,
  ) {
    final index = _getIndexOf(widgets, model.order);

    if (index > -1) {
      assert(
        widgets[index].widgetKey == model.widgetKey,
        'Seems like a different widget with the same order was already registered. '
        'Please, make sure that the order is unique for each widget.',
      );

      // replace if found
      widgets[index] = model;
    } else {
      // add if not found
      widgets.add(model);
    }

    widgets.sort((a, b) => a.order.compareTo(b.order));
  }

  void _updateIsReady() {
    isReady.value = !isInProgress && hasTooltipsInQueue;
  }

  int _getIndexOf(
    List<TutorTooltipModel> widgets,
    int order,
  ) {
    return widgets.indexWhere((e) => e.order == order);
  }

  void onDone(Function() onDone) {
    _onDoneCallback = onDone;
  }

  void dispose() {
    dismiss();
    _widgetsPlayController.close();
    isReady.dispose();
  }
}
