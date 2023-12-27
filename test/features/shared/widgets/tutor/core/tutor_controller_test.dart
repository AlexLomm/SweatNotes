import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweatnotes/shared/widgets/tutor/core/tutor_controller.dart';
import 'package:sweatnotes/shared/widgets/tutor/model/tutor_tooltip_model.dart';

void main() {
  group('TutorController', () {
    test('should register a TutorTooltipModel', () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      controller.register(model);

      expect(controller.hasTooltipsInQueue, true);
    });

    test('should unregister a TutorTooltipModel', () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      controller.register(model);
      controller.unregister(model);

      expect(controller.hasTooltipsInQueue, false);
    });

    test('should add active widgets to queue when they\'re registered', () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model);

      expect(controller.hasTooltipsInQueue, true);
    });

    test('should not add inactive widgets to queue when they\'re registered',
        () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: false,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model);

      expect(controller.hasTooltipsInQueue, false);
    });

    test('should add active widgets to queue when they\'re updated to active',
        () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: false,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model);

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model.copyWith(active: true));

      expect(controller.hasTooltipsInQueue, true);
    });

    test('should remove widgets from queue when they\'re unregistered', () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model);

      expect(controller.hasTooltipsInQueue, true);

      controller.unregister(model);

      expect(controller.hasTooltipsInQueue, false);
    });

    test(
        'should remove widgets from queue when their active status changes to false',
        () {
      final controller = TutorController();

      final model = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      expect(controller.hasTooltipsInQueue, false);

      controller.register(model);

      expect(controller.hasTooltipsInQueue, true);

      controller.register(model.copyWith(active: false));

      expect(controller.hasTooltipsInQueue, false);
    });

    test('should go to next TutorTooltipModel', () {
      final controller = TutorController();

      final model1 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      final model2 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 2,
      );

      controller.register(model1);
      controller.register(model2);

      expect(controller.hasTooltipsInQueue, true);
      expectLater(controller.widgetsPlayStream, emits(model1));
      controller.next();

      expect(controller.hasTooltipsInQueue, true);
      expectLater(controller.widgetsPlayStream, emits(model2));
      controller.next();

      expect(controller.hasTooltipsInQueue, false);
      expectLater(controller.widgetsPlayStream, emits(null));
      controller.next();
    });

    test('should do nothing when there are no tooltips in queue', () {
      final controller = TutorController();

      expect(controller.hasTooltipsInQueue, false);
      expectLater(controller.widgetsPlayStream, emits(null));
      controller.next();
    });

    test('should respect order of TutorTooltipModels', () {
      final controller = TutorController();

      final model1 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 100,
      );

      final model2 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 0,
      );

      controller.register(model1);
      controller.register(model2);

      expectLater(controller.widgetsPlayStream, emits(model2));

      controller.next();

      expectLater(controller.widgetsPlayStream, emits(model1));

      controller.next();
    });

    test('should dismiss all TutorTooltipModels', () {
      final controller = TutorController();

      final model1 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      final model2 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 2,
      );

      controller.register(model1);
      controller.register(model2);
      controller.dismiss();

      expect(controller.hasTooltipsInQueue, false);
    });

    test('should be in progress when showing tooltips', () {
      final controller = TutorController();

      final model1 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      controller.register(model1);

      expect(controller.isInProgress, false);

      controller.widgetsPlayStream.listen(
        expectAsync1((event) => expect(controller.isInProgress, true)),
      );

      controller.next();
    });

    test('should replace widgets with the same order', () {
      final controller = TutorController();

      final model1 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      final model2 = TutorTooltipModel(
        widgetKey: GlobalKey(),
        active: true,
        buildChild: (controller) => Container(),
        buildTooltip: (controller, rect) => Container(),
        order: 1,
      );

      controller.register(model1);
      controller.register(model2);

      expect(controller.hasTooltipsInQueue, true);
      expectLater(controller.widgetsPlayStream, emits(model2));
      controller.next();
    });
  });
}
