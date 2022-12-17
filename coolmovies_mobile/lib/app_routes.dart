import 'package:coolmovies/modules/home/home_route.dart';
import 'package:coolmovies/modules/home/view/pages/home_page.dart';
import 'package:coolmovies/modules/movie_details/movie_details_route.dart';
import 'package:coolmovies/modules/movie_details/view/pages/movie_details_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter router = GoRouter(
    initialLocation: HomeRoute.root,
    routes: [
      GoRoute(
        path: HomeRoute.root,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: MovieDetailsRoute.root,
        builder: (context, state) => MovieDetailsPage(
          params: state.extra as MovieDetailsPageParams,
        ),
      ),
    ],
  );
}
