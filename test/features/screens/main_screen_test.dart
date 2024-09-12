import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klontong_project/features/common/app_theme.dart';
import 'package:klontong_project/features/screens/main_screen/main_screen.dart';
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
  });

  const tProduct = [
    Product(
      id: '66e17bbbfe837603e816b966',
      categoryId: 14,
      categoryName: 'Cemilan',
      sku: 'MHZVTK',
      name: 'Ciki ciki',
      description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
      weight: 5,
      width: 5,
      length: 5,
      height: 5,
      image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
      price: 5000,
    )
  ];

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

  group('Widget test Main Screen', () {
    testWidgets(
      'Should show loading skeleton when products is loading.',
      (WidgetTester tester) async {
        // arrange
        when(() => mockProductBloc.state).thenReturn(
            const ProductState(status: ProductStatus.loadingRetrieve));

        // act
        await tester
            .pumpWidget(makeTestableWidget(const FakeProductSkeleton()));
        await tester.pumpAndSettle();

        // assert
        expect(
            find.byKey(const Key('productSkeleton')), equals(findsOneWidget));
      },
    );

    testWidgets(
      'Should show empty text when the products is empty.',
      (WidgetTester tester) async {
        // arrange
        when(() => mockProductBloc.state)
            .thenReturn(const ProductState(status: ProductStatus.empty));

        // act
        await tester.pumpWidget(makeTestableWidget(const MainScreen()));
        await tester.pumpAndSettle();

        // assert
        expect(find.text('Empty'), findsOneWidget);
      },
    );

    testWidgets(
      'Should show card list when products has data.',
      (WidgetTester tester) async {
        // arrange
        when(() => mockProductBloc.state).thenReturn(const ProductState(
          status: ProductStatus.loaded,
          data: tProduct,
        ));

        // act
        await tester.pumpWidget(makeTestableWidget(const MainScreen()));
        await tester.pumpAndSettle();

        // assert
        expect(find.byKey(const Key('productData')), findsOneWidget);
        expect(find.text('Ciki ciki'), findsOneWidget);
      },
    );

    testWidgets(
      'Should show text containing error message when state is products error.',
      (WidgetTester tester) async {
        // arrange
        const errorMessage = 'error message';
        when(() => mockProductBloc.state).thenReturn(const ProductState(
            status: ProductStatus.errorRetrieve, message: errorMessage));

        // act
        await tester.pumpWidget(makeTestableWidget(const MainScreen()));
        await tester.pumpAndSettle();

        // assert
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
  });
}
