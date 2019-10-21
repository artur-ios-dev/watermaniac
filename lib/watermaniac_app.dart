import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:watermaniac/actions/history_actions.dart';

import 'package:watermaniac/model/app_state.dart';
import 'package:watermaniac/reducers/app_state_reducer.dart';
import 'package:watermaniac/screens/home/home_page.dart';
import 'package:watermaniac/middleware/middleware.dart';
import 'package:watermaniac/actions/settings_actions.dart';

class WatermaniacApp extends StatelessWidget {
  final store = Store<AppState>(appReducer,
      initialState: AppState.defaultState(),
      middleware: createStoreMiddleware());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4C9BFB),
        accentColor: const Color(0xFFF66BBE),
        // f5bad3 (pinkish), c7d0df (grayish), fcfbfe (whiteish)
      ),
      home: StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(LoadDrinkHistoryAction());
            store.dispatch(LoadAppSettingsAction());
          },
          builder: (context, store) {
            return Material(
              type: MaterialType.transparency,
              child: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
