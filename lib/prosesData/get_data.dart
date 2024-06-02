import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> getDataKetinggianAir() async {
  final url =
      'https://zfdffrb4hk.execute-api.ap-southeast-2.amazonaws.com/default/ketinggianAir';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      data.forEach((element) {
        // Parse timestamp dari string ke DateTime
        DateTime timestamp = DateTime.parse(element["timestamp"]);

        // Mendapatkan tanggal, bulan, dan tahun dari timestamp
        int day = timestamp.day;
        int month = timestamp.month;
        int year = timestamp.year;

        // Konversi ke jumlah detik sejak epoch
        int secondsSinceEpoch = timestamp.millisecondsSinceEpoch ~/ 1000;

        // Update nilai timestamp dalam data
        element["timestamp"] = secondsSinceEpoch;
        
        // Menambahkan tanggal, bulan, dan tahun ke dalam data
        element["day"] = day;
        element["month"] = month;
        element["year"] = year;
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
