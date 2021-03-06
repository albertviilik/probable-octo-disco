import 'dart:io';

import 'package:probable_octo_disco/probable_octo_disco.dart'
    as probable_octo_disco;
import 'package:test/test.dart';

void main() {
  test('Communication with Server', () async {
    await ServerSocket.bind(InternetAddress.loopbackIPv4, 1234)
        .then((ServerSocket serverSocket) async {
      print(
          'Successfully created a socket ${serverSocket.address.address}:${serverSocket.port}');
      serverSocket.listen((Socket client) async {
        print(
            'Received a connection from ${client.address.address}:${client.port}');
      });

      await probable_octo_disco.main([
        '-a',
        serverSocket.address.address,
        '-p',
        serverSocket.port.toString()
      ]);
    });
  });
}
