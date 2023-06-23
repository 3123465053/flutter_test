import 'dart:isolate';

main(List<String> data, SendPort sendPort){
  print("newIsolate接收到数据");
  print(data);
  sendPort.send("hi");

}