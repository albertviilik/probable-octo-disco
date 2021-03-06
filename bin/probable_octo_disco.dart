import 'package:probable_octo_disco/probable_octo_disco.dart'
    as probable_octo_disco;

final config = {
  'HOST': 'localhost',
  'PORT': '1234',
};

void main(List<String> arguments) async {
  await probable_octo_disco.main([
    '-a',
    config['HOST'],
    '-p',
    config['PORT'],
  ]);
}
