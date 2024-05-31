import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> getDataKetinggianAir() async {
  final url =
      'https://kpofp5hrq7.execute-api.ap-southeast-2.amazonaws.com/default/tinggimukaair';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var waktu = 0;
      final List<dynamic> data = json.decode(response.body);
      data.forEach((element) {
        // Hapus atribut "timestamp"
        element.remove("timestamp");

        // Ubah ke jumlah detik
        waktu = waktu + 1;
        element["timestamp"] = waktu.toString();
      });
      print(data);

      return data.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
