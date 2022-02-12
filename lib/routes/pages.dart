import 'package:get/route_manager.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/views/home/home.dart';
import 'package:varanasi/views/home/tabs/artist_details/index.dart';
import 'package:varanasi/views/home/tabs/instrument_details.dart';
import 'package:varanasi/views/home/tabs/search_results.dart';
import 'package:varanasi/views/player/full.dart';

List<GetPage> get pages => [
      GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
      ),
      GetPage(
        name: Routes.searchResultPage,
        page: () => SearchResultPage(),
      ),
      GetPage(
        name: Routes.instrumentDetails,
        page: () => InstrumentDetailsPage(),
      ),
      GetPage(
        name: Routes.artistInfo,
        page: () => const ArtistDetails(),
      ),
      GetPage(
        name: Routes.fullScreenPlayer,
        page: () => const Player(),
      ),
    ];
