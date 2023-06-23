
import 'dart:isolate';

void main()
{
  mainIsolate();
}

void mainIsolate()async{
  print("创建线程");
  ReceivePort receivePort=ReceivePort();
  SendPort sendPort=receivePort.sendPort;

  Isolate isolate=await Isolate.spawnUri(
      Uri(path: "new_isolate.dart"),
      ["data1","data2"],
      sendPort
  );

  receivePort.listen((message) {
    print(message);
    receivePort.close();
    isolate.kill();
  });
}