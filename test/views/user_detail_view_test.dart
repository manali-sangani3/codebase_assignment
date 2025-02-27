import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_data_entity.dart';
import 'package:flutter_base_project/app/ui/custom_widget/cached_network_image_widget.dart';
import 'package:flutter_base_project/app/ui/screens/user_detail/user_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('UserDetailView Tests', () {
    final testUser = UserData(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      avatar: 'https://example.com/avatar.jpg',
    );

    Widget createTestWidget(UserData user) {
      return MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => UserDetailView(details: user),
            ),
          ],
        ),
      );
    }

    testWidgets('Displays user details correctly', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget(testUser));

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('john.doe@example.com'), findsOneWidget);
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Image &&
                widget.image is CachedNetworkImageProvider &&
                (widget.image as CachedNetworkImageProvider).url ==
                    "https://example.com/avatar.jpg",
          ),
          findsOneWidget,
        );
      });
    });

    testWidgets('Handles missing user details gracefully',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        // Arrange: Create test user data with missing details
        final testUser = UserData(
          firstName: '', // Empty name
          lastName: '',
          email: '',
          avatar: 'https://example.com/avatar.jpg',
        );

        // Act: Pump the widget
        await tester.pumpWidget(createTestWidget(testUser));
        await tester.pumpAndSettle();

        // Assert: Check that empty text fields are handled
        expect(find.text(''), findsWidgets); // Empty fields should be found
        expect(find.text(' '), findsNothing); // No invalid spaces

        // Assert: Check that the CachedNetworkImageWidget is present
        final imageWidget = tester.widget<CachedNetworkImageWidget>(
          find.byType(CachedNetworkImageWidget),
        );

        expect(imageWidget.imageUrl, 'https://example.com/avatar.jpg');

        // Assert: Ensure the image is found
        expect(find.byType(CachedNetworkImageWidget), findsOneWidget);
      });
    });

    testWidgets('Displays email icon and contact info section',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget(testUser));

        expect(find.byIcon(Icons.email_rounded), findsOneWidget);
        expect(find.textContaining('Contact Info'), findsOneWidget);
      });
    });
  });
}
