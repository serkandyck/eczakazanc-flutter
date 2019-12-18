import 'dart:async';
import 'dart:convert';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cache_utils.dart';
import 'dialog_utils.dart';

class NetworkUtils {
  static final String host = productionHost;
	static final String productionHost = 'https://app.eczakazanc.com';
	static final String developmentHost = 'http://192.168.0.12:8000';
  static NetworkUtils _instance = new NetworkUtils.internal();
  NetworkUtils.internal();
  factory NetworkUtils() => _instance;

  static dynamic authenticateUser(String email, String password) async {
		var uri = host + '/api/login';
    var body = json.encode({"email": email, "password": password});

		try {
			final response = await http.post(
				uri,
        headers: {"Content-Type": "application/json", "Accept": "application/json"},
				body: body
			).timeout(const Duration(seconds: 15));

			final responseJson = json.decode(response.body);
			return responseJson;

		} catch (exception) {
			
			if(exception.toString().contains('SocketException')) {
				return 'NetworkError';
			} else {
				return null;
			}
		}
	}

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
		scaffoldKey.currentState.showSnackBar(
			new SnackBar(
				content: new Text(message ?? 'Bağlantı hatası'),
			)
		);
	}

  Future<dynamic> get(BuildContext context, String uri) async {
    Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json"};
    
    var url = host + uri;

    await getCache('jwt-token').then((result) {
      headers['Authorization'] = 'Bearer ' + result;
    });

    try {
      final response = await http.get(url, headers: headers);
      print(response.body);
      final int statusCode = response.statusCode;
      final errorMsg = json.decode(response.body);
      print("#######################################");
      print("get ### ${url}");
      print("giden header ### ${headers}");
      //print("gelen header ### ${response.headers}");
      //print("gelen cevap ### ${response.body}");

      if (statusCode == 401) {
        await clearCache('jwt-token');
        return Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
      }
      if (statusCode == 404) {
        throw new Exception("404，Aranılan sayfa bulunamadı!");
      }
      if (statusCode == 500) {
        throw Exception("Ağ hatası：${response.body}, Sistem hatası");
      }
      if (statusCode == 200) {
        return json.decode(response.body);
      }
      throw new Exception("Bağlantı hatası:(HTTP:${statusCode})，Lütfen internet bağlantınızı kontrol ediniz！");
    } on Exception catch (e) {
      showDialogSingleButton(context, "Hata!",
          e.toString().replaceAll(new RegExp(r'Exception: '), ''), "OK");
    }
  }

  Future<dynamic> post(BuildContext context, String uri,
      {body, encoding}) async {
    Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json"};
    var url = host + uri;
    var bodyRdy = json.encode(body);

    await getCache('jwt-token').then((result) {
      headers['Authorization'] = 'Bearer ' + result;
    });

    try {
      final response = await http.post(url,
          body: bodyRdy, headers: headers, encoding: encoding);
      final int statusCode = response.statusCode;
      final errorMsg = json.decode(response.body);
      print("#######################################");
      print("post ### ${url}");
      print("giden header ### ${headers}");
      //print("gelen header ### ${response.headers}");
      //print("giden body:${body}");
      print("gelen cevap ### ${response.body}");

      if (statusCode == 401) {
        await clearCache('jwt-token');
        return Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
      }
      
      if (statusCode == 404) {
        throw new Exception("404，Aranılan sayfa bulunamadı!");
      }
      if (statusCode == 500) {
        throw Exception("Ağ hatası：${response.body}, Sistem hatası");
      }
      if (statusCode == 200) {
        return json.decode(response.body);
      }
      throw new Exception("Bağlantı hatası:(HTTP:${statusCode})，Lütfen internet bağlantınızı kontrol ediniz！");
    } on Exception catch (e) {
      showDialogSingleButton(context, "Hata!",
          e.toString().replaceAll(new RegExp(r'Exception: '), ''), "OK");
    }
  }

  // Örnek upload request

  /*Future<dynamic> upload(
      BuildContext context, String url, List<http.MultipartFile > imageFileList,
      {Map headers, body, encoding}) async {
      await getCache('jwt-token').then((result) {
      headers['Authorization'] = result;
    });

    // 增加body 字段 (使用很挫的方式，因为field加入会报错)
    url = url + "?1=1";
    body.forEach((k, v) {
      url = url+"&${k}=${v}";
    });

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);

    // 添加需要上传的图片
    imageFileList.forEach((imageFile){
      request.files.add(imageFile);
    });

    // 增加body 字段，这里有bug
    body.forEach((k, v) {
      //request.fields[k] = v;
    });
    // 增加header字段
    headers.forEach((k, v) {
      request.headers[k] = v;
    });
    // 开始发送请求
    try {
      final responseStream = await request.send();
      String data = await Utf8Codec(allowMalformed: true)
          .decodeStream(responseStream.stream);
      final int statusCode = responseStream.statusCode;
      // 如果包含Token ，那么更新TOKEN
      if (responseStream.headers.containsKey('authorization')) {
       setCache('jwt-token',responseStream.headers['authorization']);
      }
      // 如果Token 过期，强制跳转到登陆页面
      if (statusCode == 401) {
        return Navigator.of(context).pushReplacementNamed('/login');
      }
      if (statusCode == 404) {
        throw new Exception("404，请求页面${url}不存在！");
      }
      if (statusCode == 500) {
        throw Exception("网络500错误,错误信息：，请联系开发人员处理");
      }
      if (statusCode == 200) {
        print("请求接口${url}，请求头${headers}，请求body:${body}，请求结果${data}");
        return json.decode(data);
      }
      throw new Exception("网络异常:(HTTP:${statusCode})，请检查网络后重试！");
    } on Exception catch (e) {
      showDialogSingleButton(context, "网络错误！",
          e.toString().replaceAll(new RegExp(r'Exception: '), ''), "OK");
    }
  }*/
}
