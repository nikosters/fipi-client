import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fipi_client/app.dart';

void main() {
  testWidgets('app starts with subject screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FipiApp()));
    expect(find.text('Предметы'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
