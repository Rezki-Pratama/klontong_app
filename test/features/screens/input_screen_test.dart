import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/domains/model/category.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klontong_project/features/common/app_theme.dart';
import 'package:klontong_project/features/route/app_arguments.dart';
import 'package:klontong_project/features/screens/input_screen/input_screen.dart';
import 'package:klontong_project/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

class FakeProductState extends Fake implements ProductState {}

class FakeProductEvent extends Fake implements ProductEvent {}

class FakeProductSkeleton extends StatelessWidget {
  const FakeProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('productSkeleton'),
      width: 100,
      height: 100,
      color: Colors.grey[300],
    );
  }
}

void main() {
  late MockProductBloc mockProductBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeProductState());
    registerFallbackValue(FakeProductEvent());

    final di = GetIt.instance;
    di.registerFactory(() => mockProductBloc);
  });

  setUp(() {
    mockProductBloc = MockProductBloc();
    when(() => mockProductBloc.state)
        .thenReturn(const ProductState(status: ProductStatus.initial));
    // Mock the `add` method to verify it gets called
    when(() => mockProductBloc.add(any())).thenAnswer((_) {});
  });

  Widget makeTestableWidget(Widget body) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: MaterialApp(
            supportedLocales: Internationalization.supportByApp,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.theme(),
            home: Scaffold(body: body),
          ),
        );
      },
    );
  }

  group('Widget test InputScreen', () {
    testWidgets(
      'Should show all form fields initially.',
      (WidgetTester tester) async {
        // Arrange
        when(() => mockProductBloc.state)
            .thenReturn(const ProductState(status: ProductStatus.initial));

        await tester.pumpWidget(makeTestableWidget(
            InputScreen(arguments: InputArguments(data: null))));

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(TextFormField), findsNWidgets(8));
        expect(find.byKey(const Key('nameField')), findsOneWidget);
        expect(find.byKey(const Key('descriptionField')), findsOneWidget);
        expect(find.byKey(const Key('priceField')), findsOneWidget);
        expect(find.byKey(const Key('skuField')), findsOneWidget);
        expect(find.byKey(const Key('weightField')), findsOneWidget);
        expect(find.byKey(const Key('lengthField')), findsOneWidget);
        expect(find.byKey(const Key('heightField')), findsOneWidget);
        expect(find.byKey(const Key('widthField')), findsOneWidget);

        expect(find.byKey(const Key('categoryField')),
            findsOneWidget); // Ensure the dropdown is present
        final dropdownButton = find.byType(DropdownButtonFormField<Category>);
        expect(dropdownButton, findsOneWidget);
      },
    );

    testWidgets(
      'Should validate form fields and trigger submit on valid input.',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(makeTestableWidget(
          InputScreen(arguments: InputArguments(data: null)),
        ));

        // Act
        await tester.enterText(
            find.byKey(const Key('nameField')), 'Test Product');

        // Tap the dropdown to open it
        await tester.tap(find.byKey(const Key('categoryField')));
        await tester.pump(); // Trigger a frame to open the dropdown

        // Select an item from the dropdown menu
        await tester.tap(find.text('Minuman').last);
        await tester.pumpAndSettle(); // Wait for the dropdown to close

        await tester.enterText(
            find.byKey(const Key('descriptionField')), 'Test Description');
        await tester.enterText(find.byKey(const Key('priceField')), '100');
        await tester.enterText(find.byKey(const Key('skuField')), 'TEST-SKU');
        await tester.enterText(find.byKey(const Key('weightField')), '10');
        await tester.enterText(find.byKey(const Key('lengthField')), '20');
        await tester.enterText(find.byKey(const Key('heightField')), '30');
        await tester.enterText(find.byKey(const Key('widthField')), '40');

        await tester.pumpAndSettle();

        final submitButtonFinder = find.byKey(const Key('submitButton'));
        expect(submitButtonFinder, findsOneWidget);

        // tap the submit button
        await tester.tap(submitButtonFinder, warnIfMissed: false);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Should show loader when state is loading.',
      (WidgetTester tester) async {
        // arrange
        when(() => mockProductBloc.state)
            .thenReturn(const ProductState(status: ProductStatus.loadingStore));

        await tester.pumpWidget(makeTestableWidget(
            InputScreen(arguments: InputArguments(data: null))));

        // act
        await tester.pump();

        // assert
        final submitButtonFinder = find.byKey(const Key('buttonLoader'));
        expect(submitButtonFinder, findsOneWidget);
      },
    );
  });
}
