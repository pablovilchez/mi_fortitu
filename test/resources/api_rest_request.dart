
// función para llamar a la api de testeo y hacerle una petición

import 'package:http/http.dart' as http;

Future<void> apiRestRequest() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  print(response.body);
}
