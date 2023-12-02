// ignore_for_file: file_names

class UseRole {
  Future<dynamic> getRole(request) async {
    try {
      var response =
          await request.get('http://192.168.56.1:8000/api/islogedin');
      return response;
    } catch (error) {
      // Handle the error, e.g., log it or show an error message
      rethrow; // Re-throw the error if needed
    }
  }
}
