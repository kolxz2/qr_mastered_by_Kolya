import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_code/requests/post_model.dart';
import 'package:intl/intl.dart';

class HttpService {
  /*Map<String, String> headers = HashMap();
  headers.addAll({
    
  });*/

  static const String postsURL =
      "https://78.29.9.120/prr/hs/HTTPShooter/Authorization";
  /*static const String autoryzed =
      "192.16https://8.1.111/prr/hs/HTTPShooter/Authorization?Login=adm&Password=111";*/
  static const String licenseURL =
      "https://78.29.9.120/prr/hs/HTTPShooter/Familiarized";

  static Future<Post> getPosts(String? login, String? password) async {
    String url = "$postsURL?Login=$login&Password=$password";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      Post data = Post.fromJson(json.decode(res.body));
      return data;
    } else {
      throw "Всё плохо";
    }
  }

  static Future<bool> getLicense(String? login) async {
    var date = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now());
    String url = "$licenseURL?Login=$login&Date=${date.toString()}";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

    /* HttpClient client = HttpClient();
    var url = Uri.parse(
        "https://192.168.1.111/prr/hs/HTTPShooter/Authorization?Login=adm&Password=111");
    try {
      HttpClientRequest request = await client.getUrl(url);
      request.headers.clear();
      request.headers.add(name, value)
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      print(stringData);
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
    client.getUrl(url).then((HttpClientRequest request) {
      print(request.headers);
      print(request.connectionInfo);
      return request.close();
    }).then((HttpClientResponse response) {
      print(response.connectionInfo);
    });*/