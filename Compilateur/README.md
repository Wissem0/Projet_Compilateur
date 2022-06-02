int soustraction(int a,int x){
a = a - 1;
return a;
}

int addition(int a){
a = a + 1;
return a;
}

main() {
  int a = 0;
  int b = 0;
  int c = 2;
  b = addition(a);
  c = soustraction(a, b);
}