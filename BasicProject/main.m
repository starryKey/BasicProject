//
//  main.m
//  BasicProject
//
//  Created by Li_JinLin on 17/2/6.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//01返回指针类型数据的函数
char * toUpStr(char *a){
    char *b = a; //保留最初地址，因为后面的循环会改变字符串最初地址；
    int len = 'a' - 'A';//大小写ASCII码差值相等
    while (*a != '\0') {//字符串是否结束
        if (*a > 'a' && *a < 'z') {//如果是小写
            *(a++) -= len;   //*a表示数组对应的字符 ++ 代表移动到下个字符；
        }
    }
    return b;
}

//02指针作为参数进行传递
int operate(int a,int b, int *c){
    *c = a - b;
    return a + b;
}

//03函数指针
int sum(int a,int b){
    return a+b;
}
int sub(int a,int b){
    return a-b;
}

//函数指针作为参数传递
int test(int a,int b,int (*p)(int m,int n)){
    return p(a,b);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
         int a = 1;
         int *p;
         p = &a;
         printf("a的地址%x P的地址 %x\n",&a,p);
         printf("a = %d p = %d\n",a,*p);
         *p = 2;
         printf("a = %d p = %d\n",a,*p);
         //说明: int *p；中的*只表示p变量是一个指针变量，而打印*p的时候,*p中的*是操作符，表示P指针指向的变量的存储空间（当前就是1），同时我们也看到了*p = a；修改了*p也就是修改了p指向的存储空间的内容，也就是修改了a的值，即第二次打印的时候是2；
         
         int b = 8;
         char c = 1;
         int *q = &c;
         printf("b = %x c = %x q = %x\n",&b,c,&q);
         printf("b = %d c = %d q = %d\n",b,c,q);
         //说明指针所指向的类型必须和定义指针时声明的类型相同；
         //指针变量占用的空间和它所指向的变量类型无关，只跟编译器位数有关
         
         //数组与指针 由于数组的存储是连续的，数组名就是数组的地址。
         int m[] = {1,2,3};
         int *n = &m[0]; //等价于*n = a;
         printf("%s", m);
         //C语言中字符串就是字符数组
         char f[]="hello";
         char *x;
         x=f;
         */
        
        //函数指针
        //01返回指针类型的函数调用
        char a[] = "hello";
        char *p = toUpStr(a);
        printf("%s\n",p);
        
        //02函数只能有一个返回值，如果需要返回多个值，只要将指针作为函数参数传递就可以了
        int x = 2,y=3,z,n;
        n = operate(x, y, &z);
        printf("a + b = %d,a - b = %d\n",n, z);
        
        //03函数也是在内存中存储的，当然函数也是有一个起始地址（事实上函数名就是函数的起始地址），这里同样需要弄清函数指针的关系。函数指针定义的形式：返回值类型（*指针变量名)(形参1，形参2)，拿到函数指针其实就相当于我们拿到了这个函数，函数的操作都可以通过指针来完成，而且通过前面的例子可以看出指针作为C语言的数据类型，可以作为参数，作为返回值，那么当然函数指针同样可以作为函数和返回值。
        //函数指针作为返回值
        int W = 6,H = 8;
        int (*U)(int ,int) = sum;//函数名就是首地址，等价于：int (*p)(int ,int);p=sum;
        int c = U(W,H);
        printf("函数指针作为返回值： a + b = %d\n",c);
        //函数指针作为参数
        printf("函数指针作为参数SUM a + b =  %d\n",test(W, H, sum));
        printf("函数指针作为参数SUB a - b =  %d\n",test(W, H, sub));
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
