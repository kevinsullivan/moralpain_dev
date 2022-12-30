import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moraldistress/assets/home_constants.dart' as home_constants;
import 'package:moraldistress/assets/constants.dart' as constants;
import 'package:moraldistress/home/view/home_route.dart';
import 'package:moraldistress/thermometer/view/thermometer_route.dart';

class MockCanvas extends Mock implements Canvas {}

void main() {
  group('HomeRoute', () {
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeRoute()));
    }

    group('renders', () {
      testWidgets('AppBar with correct title', (tester) async {
        await pumpApp(tester);
        expect(find.byType(AppBar), findsOneWidget);
        AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.title, isNotNull);
        expect(appBar.title, isA<Text>());
        Text title = appBar.title as Text;
        expect(title.data, equals(constants.APPBAR_TEXT));
      });

      testWidgets('Scaffold with CustomPaint with HomePainter', (tester) async {
        await pumpApp(tester);
        expect(find.byType(Scaffold), findsOneWidget);
        Scaffold scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.body, isNotNull);
        expect(scaffold.body, isA<CustomPaint>());
        CustomPaint customPaint = scaffold.body! as CustomPaint;
        expect(customPaint.painter, isA<HomePainter>);
      });

      testWidgets('button with correct text', (tester) async {
        await pumpApp(tester);
        expect(find.byType(ElevatedButton), findsOneWidget);
        ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        expect(button.child, isNotNull);
        expect(button.child, isA<Text>());
        Text text = button.child as Text;
        expect(text.data, equals(home_constants.HOME_BUTTON_TEXT));
      });
    });

    testWidgets('button sends user to thermometer screen when clicked',
        (tester) async {
      await pumpApp(tester);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(ThermometerRoute), findsOneWidget);
    });
  });

  group('HomePainter', () {
    final instance = HomePainter();
    final canvas = MockCanvas();
    final portraitSize = Size(8.5, 11);
    final squareSize = Size(200, 200);
    final landscapeSize = Size(3840, 2160);

    setUp(() {
      when(() => canvas.drawCircle(any(), any(), any())).thenAnswer((_) {});
    });

    setUpAll(() {
      registerFallbackValue(Offset.zero);
      registerFallbackValue(Paint());
    });

    group('shouldRepaint', () {
      test('returns false if same instance is passed in', () {
        expect(instance.shouldRepaint(instance), isFalse);
      });

      test('returns true if other instance is passed in', () {
        final other = HomePainter();
        expect(instance.shouldRepaint(other), isTrue);
      });
    });

    group('isPortrait', () {
      test('returns true if parameter\'s height is more than its width', () {
        expect(instance.isPortrait(portraitSize), isTrue);
      });

      test('returns false if parameter\'s height is equal to its width', () {
        final size = Size(200, 200);
        expect(instance.isPortrait(squareSize), isFalse);
      });

      test('returns false if parameter\'s height is less than its width', () {
        final size = Size(3840, 2160);
        expect(instance.isPortrait(landscapeSize), isFalse);
      });
    });

    group('paintPortrait', () {
      test('draws 4 circles', () {
        instance.paintPortrait(canvas, portraitSize);
        verify(() => canvas.drawCircle(any(), any(), any())).called(4);
      });
    });

    group('paintLandscape', () {
      test('draws 3 circles', () {
        instance.paintLandscape(canvas, landscapeSize);
        verify(() => canvas.drawCircle(any(), any(), any())).called(3);
      });
    });

    group('paint', () {
      test('calls paintPortrait if given size is portrait', () {
        instance.paint(canvas, portraitSize);
        verify(() => canvas.drawCircle(any(), any(), any())).called(4);
      });

      test('calls paintLandscape if given size is square', () {
        instance.paint(canvas, squareSize);
        verify(() => canvas.drawCircle(any(), any(), any())).called(3);
      });

      test('calls paintLandscape if given size is landscape', () {
        instance.paint(canvas, landscapeSize);
        verify(() => canvas.drawCircle(any(), any(), any())).called(3);
      });
    });
  });
}
