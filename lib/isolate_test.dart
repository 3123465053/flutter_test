import 'dart:isolate';

void main(){
  mainIsolate();
}

void mainIsolate(){
  print("mainIsolate stsrt");
  Isolate.spawn(newIsolate,null);
  print("mainIsolate end");
}

void newIsolate(Null){
  print("newIsolate start");
  for(int i=0;i<100000000;i++)
    print(i);
  print("newIsolate end");
}