//
//  PropertyViewController.m
//  BasicProject
//
//  Created by Li_JinLin on 17/2/7.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

#import "PropertyViewController.h"
#import <objc/Object.h>
#import <objc/runtime.h>
@interface PropertyViewController ()
@property (nonatomic, weak)   UIView    *weakView;
@property (nonatomic, strong) UIView    *strongView;
@property (nonatomic, copy)   NSString  *str;
@property (nonatomic, assign) NSInteger nCount;
@end

@implementation PropertyViewController

//用Objective-C等面向对象语言编程时，‘对象’（object）就是“基本构造单元”，开发者可以通过对象来存储并传递数据，在对象之间传递数据并执行任务的过程就叫消息传递，当程序运行起来后，为其提供相关支持的代码叫做“Objective-C运行期环境”（Objective-C runtime）,它提供了一些使得对象之间能够传递消息的重要函数，并且包含创建类实例使用的全部逻辑。

//assign  '设置方法' 只会执行针对‘纯量类型’的简单赋值操作
//strong  此特质表明该属性定义了一种“拥有关系”，为这种属性设置新值时，设置方法会先保留新值，并释放旧值，然后再将新值设置上去
//weak    此特质表明该属性定义了一种“非拥有关系”，为这种属性设置新值时，设置方法既不保留新值，也不会释放旧值。此特质同assign类似，然而在属性所指的对象遭到摧毁时，属性值也会清空
//copy    此特质所表达的所属关系与strong类似。然而设置方法并不保留新值，而是将其拷贝（copy）。当属性类型为NSString * 时，经常使用此特质来保护其封装性，因为传递给设置方法的新值有可能指向一个NSMutableString类的实例，这个类是NSString的子类，表示一种可以修改其值得字符串，此时若是不拷贝字符串，那么设置完属性后，字符串的值就可能会在对象不知情的情况下遭人修改。所以这时就要拷贝一份“不可变”的字符串，确保对象中的字符串值不会无意间变动。只要实现属性所用的对象是“可变的”，就应该在设置新属性值时拷贝一份。
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIView *)weakView{
    if (!_weakView) {
        //弱引用，
        UIView *weakView = [[UIView alloc]init];
        _weakView = weakView;
        _weakView.backgroundColor = [UIColor redColor];
    }
    return _weakView;
}

- (UIView *)strongView{
    if (!_strongView) {
        _strongView = [[UIView alloc]init];
        _strongView.backgroundColor = [UIColor greenColor];
    }
    return _strongView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
