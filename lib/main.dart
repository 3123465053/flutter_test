
import 'dart:isolate';

void main()
{
  mainIsolate();
}

void mainIsolate(){
  print("mainIsolate start");
  print("当前Isolate名称：${Isolate.current.debugName}");
  ReceivePort receivePort=ReceivePort();        //接收端口
  SendPort sendPort=receivePort.sendPort;       //发送给当前Isolate的端口

  Isolate.spawn(newIsolate,sendPort);      //创建将一个Isolate,第一个参数为为谁创建一个Isolate，第二个参数为新创建的Isolate的参数。
  receivePort.listen((message) {    //监听接收端口发来的消息
    print(message);
    receivePort.close();         //接收到一个消息之后就关闭接收端口
  });
  print("mainIsolate end");
}

void newIsolate(SendPort sendPort){
  print("当前Isolate名称：${Isolate.current.debugName}");
  sendPort.send("Hi mainIsolate");

}