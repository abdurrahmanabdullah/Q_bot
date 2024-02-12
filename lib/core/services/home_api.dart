import 'package:http/http.dart' as http;
import 'package:q_bot/core/models/counter_model.dart';
import 'package:q_bot/core/models/counter_waiting_model.dart';
import 'package:q_bot/ui/shared/api_url.dart';

class CounterAPI {
  /// This is the only Service or API class

  /// Tokens allocated for the current counter API class

  Future<List<CounterModel>?> getCounterAPI() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${coreUrl}count/serving'),
      );

      if (response.statusCode == 200) {
        List<CounterModel> counter = counterModelFromJson(response.body);

        return counter;
      }
    } catch (e) {
      return [CounterModel(tokenId: 0, counter: 0)];
    }
    return null;
  }

  /// Next Tokens API class

  Future<List<Datum>?> getCounterWaitingAPI() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${coreUrl}count/all/waiting/PROCESSING'),
      );

      if (response.statusCode == 200) {
        List<CounterWaitingModel> waiting =
            counterWaitingModelFromJson(response.body);

        List<Datum> simpleWaitingList = [];

        for (final d in waiting) {
          for (int i = 0; i < d.data!.length; i++) {
            simpleWaitingList.add(d.data![i]);
            // print('Value at index $i: ${d.data![i].tokenId}');
          }
        }
        // print(response.body);
        return simpleWaitingList;
      }
    } catch (e) {}
    return null;
  }

  /// Hold Tokens API class

  Future<List<Datum>?> getCounterHoldAPI() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${coreUrl}count/all/waiting/HOLD'),
      );

      if (response.statusCode == 200) {
        List<CounterWaitingModel> hold =
            counterWaitingModelFromJson(response.body);

        List<Datum> simpleHoldList = [];

        for (final d in hold) {
          for (int i = 0; i < d.data!.length; i++) {
            simpleHoldList.add(d.data![i]);
          }
        }
        print(response.body);
        return simpleHoldList;
      }
    } catch (e) {}
    return null;
  }
}
