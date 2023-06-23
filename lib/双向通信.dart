
import 'dart:isolate';

void main(){
  mainIsolate();
}

void mainIsolate()async{
  print("mainIsolate start");
  print("当前Isolate名称:${Isolate.current.debugName}");
  ReceivePort receivePort=ReceivePort();     //接收端口(创建接收端口的同时会生成发送端口)
  SendPort sendPort=receivePort.sendPort;
  Isolate.spawn(newIsolate,sendPort);  //sendPort是向当前Isolate发送消息的端口，

  SendPort sendPortNew=await receivePort.first;    //得到向newIsolate发送消息的端口

  var msg=await sendToRecive(sendPortNew,"hi");
  print(msg);
  print("mainIsolate end");
}

void newIsolate(SendPort sendPorts) async{
  print("newIsolate start");
  print("当前Isolate${Isolate.current.debugName}");
  ReceivePort receivePort=ReceivePort();
  SendPort sendPort=receivePort.sendPort;
  sendPorts.send(sendPort);           //把自己的发送端口发给mainIsolate

  await for(var msg in receivePort){
 //   print(msg);
    var data =msg[0];                //消息内容
    print(data);
    SendPort sendPorta1=msg[1];      //给mainIsolate发送消息端口
    sendPorta1.send("hi mainIsolate");     //向mainIsolate发送消息
  }

  print("newIsolate end");
}

Future sendToRecive(SendPort port,message){
  print("发送消息给newIsolate:${message}");
  ReceivePort receivePort=ReceivePort();
  port.send([message,receivePort.sendPort]);    //第二消息把发送给mainIsolate的端口发送给newIsolate
  return receivePort.first;           //返回从newIsolate接收到的消息给mainIsolate；
}
