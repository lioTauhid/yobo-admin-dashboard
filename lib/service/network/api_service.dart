abstract class ApiServices {
  Future<dynamic> get(String endPoint, {dynamic header, dynamic query});

  Future<dynamic> post(String endPoint, dynamic payloadObj, {dynamic header});

  Future<dynamic> put(String endPoint, dynamic payloadObj, {dynamic header});

  Future<dynamic> delete(String endPoint, {dynamic header, dynamic query});
}
