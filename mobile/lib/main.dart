import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line/blocs/affluence/affluence_bloc.dart';
import 'package:line/blocs/geolocate/geolocate_bloc.dart';
import 'package:line/blocs/notification/notification_bloc.dart';
import 'package:line/blocs/visit/visit_bloc.dart';
import 'package:line/providers/visit.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/search/search_bloc.dart';
import 'env/env.dart';
import 'providers/api.dart';
import 'providers/shop.provider.dart';
import 'screens/home.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({required this.prefs});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      create: (context) => NotificationBloc(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Api>(
            create: (context) => Api(
              authority: env['api_authority'] as String,
              endpoint: env['api_endpoint'] as String,
              endpointPath: env['api_path'] as String,
              port: env['api_port'] as int,
            ),
          ),
          RepositoryProvider<ShopProvider>(
            create: (context) =>
                ShopProvider(api: RepositoryProvider.of<Api>(context)),
          ),
          RepositoryProvider<VisitProvider>(
            create: (context) =>
                VisitProvider(api: RepositoryProvider.of<Api>(context)),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(
                  api: RepositoryProvider.of<Api>(context),
                  shopProvider: RepositoryProvider.of<ShopProvider>(context)),
            ),
            BlocProvider<AffluenceBloc>(
              create: (context) => AffluenceBloc(
                  api: RepositoryProvider.of<Api>(context),
                  shopProvider: RepositoryProvider.of<ShopProvider>(context)),
            ),
            BlocProvider<VisitBloc>(
              create: (context) => VisitBloc(
                  api: RepositoryProvider.of<Api>(context),
                  visitProvider: RepositoryProvider.of<VisitProvider>(context),
                  notificationBloc: BlocProvider.of<NotificationBloc>(context)),
            ),
            BlocProvider<GeolocateBloc>(
              create: (context) => GeolocateBloc()..add(GeolocateStart()),
            )
          ],
          child: Home(prefs: prefs),
        ),
      ),
    );
  }
}
