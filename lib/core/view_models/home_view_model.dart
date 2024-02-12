import 'dart:async';

import 'package:q_bot/core/enums/view_state.dart';
import 'package:q_bot/core/models/counter_model.dart';
import 'package:q_bot/core/models/counter_waiting_model.dart';
import 'package:q_bot/core/services/home_api.dart';
import 'package:q_bot/core/view_models/base_view_model.dart';
import 'package:q_bot/locator.dart';

class HomeViewModel extends BaseViewModel {
  /// LazySingleton CounterAPI object using GetIt
  final CounterAPI _counterAPI = locator<CounterAPI>();

  late List<CounterModel> counter = [CounterModel(tokenId: 0, counter: 0)];

  late List<CounterModel> tempCounter;

  late List<Datum> counterWaiting = [
    Datum(tokenId: 0, id: 0, tCounterCategories: '')
  ];
  late List<Datum> counterHold = [
    Datum(tokenId: 0, id: 0, tCounterCategories: '')
  ];

  /// Periodic timer for continuous API calls
  Timer? myTime;

  /// Current assigned tokens for counters
  Future<void> getCounter() async {
    setViewState(ViewState.busy);

    counter = (await _counterAPI.getCounterAPI())!;

    setViewState(ViewState.idle);
  }

  /// Next tokens
  Future<void> getCounterWaiting() async {
    setViewState(ViewState.busy);

    counterWaiting = (await _counterAPI.getCounterWaitingAPI())!;
    // print(counterWaiting.length);

    setViewState(ViewState.idle);
  }

  /// Hold Tokens
  Future<void> getCounterHold() async {
    setViewState(ViewState.busy);

    counterHold = (await _counterAPI.getCounterHoldAPI())!;
    //print(counterWaiting.length);
    setViewState(ViewState.idle);
  }
}
