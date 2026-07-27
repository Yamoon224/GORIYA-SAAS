import 'package:flutter_test/flutter_test.dart';

import 'package:entreprise_desktop/main.dart';

void main() {
  testWidgets('App renders the webview screen', (WidgetTester tester) async {
    await tester.pumpWidget(const GoriyaSaasApp());
    expect(find.byType(WebViewScreen), findsOneWidget);
  });
}
