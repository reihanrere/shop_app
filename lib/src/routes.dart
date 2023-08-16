import 'package:go_router/go_router.dart';
import '../src/features/features.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    ...Home.routes,
    ...Product.routes,
  ],
);
