import 'package:get/route_manager.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/views/home/home.dart';
import 'package:varanasi/views/home/tabs/instrument_details.dart';
import 'package:varanasi/views/home/tabs/search_results.dart';

List<GetPage> get pages => [
      GetPage(name: Routes.home, page: () => const HomeScreen()),
      GetPage(
          name: Routes.searchResultPage, page: () => const SearchResultPage()),
      GetPage(
        name: Routes.instrumentDetails,
        page: () => const InstrumentDetailsPage(),
      ),
    ];
