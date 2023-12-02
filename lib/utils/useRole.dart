// ignore_for_file: file_names

class UseRole {
  Future<dynamic> getRole(request) async {
    try {
      var response = await request
          .get('https://web-production-276d.up.railway.app/api/islogedin');
      return response;
    } catch (error) {
      // Handle the error, e.g., log it or show an error message
      rethrow; // Re-throw the error if needed
    }
  }
}
