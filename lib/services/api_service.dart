import 'package:http/http.dart' as http;

class APIService {
  const APIService();

  // final Function(Object? payload) httpFunction;
  // final Object? payload;

  Future<Object> sendRequest({
    required Future<http.Response> Function(String?) httpFunction,
    String? payload,
  }) async {
    final Object asyncResponse;
    if (payload != null) {
      try {
        asyncResponse = await httpFunction(payload);
        return asyncResponse;
      } catch (error) {
        print(error);
        return {};
      }
    } else {
      asyncResponse = await httpFunction(null);
      return asyncResponse;
    }
  }
}
