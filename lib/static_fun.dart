class Person{
  static int a=9;
  int b=9;

     int fun(){
    return a+b;
  }

  static int fun2(){
       return a;
  }
}

void main(){

  Person person=Person();
  print(person.fun());
  print(Person.fun2());
}