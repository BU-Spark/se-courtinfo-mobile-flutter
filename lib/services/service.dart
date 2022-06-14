import 'package:http/http.dart' as http;

class ReturnHttpPost<T> {
  var body;
  ReturnHttpPost(http.Response res) {
    body = res.body;
  }
}

class HttpService {
  final String address = "";

  Uri apiAddress(String apiAddr) => Uri.parse(address + apiAddr);

  final Map<String, String> contentType = <String, String>{
    "form": "application/x-www-form-urlencoded"
  };
}
