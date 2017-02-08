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
//用Objective-C等面向对象语言编程时，‘对象’（object）就是“基本构造单元”，开发者可以通过对象来存储并传递数据，在对象之间传递数据并执行任务的过程就叫消息传递，当程序运行起来后，为其提供相关支持的代码叫做“Objective-C运行期环境”（Objective-C runtime）,它提供了一些使得对象之间能够传递消息的重要函数，并且包含创建类实例使用的全部逻辑。

//assign  '设置方法' 只会执行针对‘纯量类型’的简单赋值操作
//strong  此特质表明该属性定义了一种“拥有关系”，为这种属性设置新值时，设置方法会先保留新值，并释放旧值，然后再将新值设置上去
//weak    此特质表明该属性定义了一种“非拥有关系”，为这种属性设置新值时，设置方法既不保留新值，也不会释放旧值。此特质同assign类似，然而在属性所指的对象遭到摧毁时，属性值也会清空
//copy    此特质所表达的所属关系与strong类似。然而设置方法并不保留新值，而是将其拷贝（copy）。当属性类型为NSString * 时，经常使用此特质来保护其封装性，因为传递给设置方法的新值有可能指向一个NSMutableString类的实例，这个类是NSString的子类，表示一种可以修改其值得字符串，此时若是不拷贝字符串，那么设置完属性后，字符串的值就可能会在对象不知情的情况下遭人修改。所以这时就要拷贝一份“不可变”的字符串，确保对象中的字符串值不会无意间变动。只要实现属性所用的对象是“可变的”，就应该在设置新属性值时拷贝一份。
@end

@implementation PropertyViewController


#pragma mark -- 强引用和弱引用的区别 ： 02布局上的区别
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.view addSubview:self.weakView];
    //弱引用和强引用布局的区别：弱引用可以直接布局，强引用需要添加到self.view上
    [self.view addSubview:self.strongView];
    NSLog(@"--->%@",self.weakView);
    
}

#pragma mark -- 强引用和弱引用的区别 ： 03移除上的区别
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_weakView removeFromSuperview];
    [_strongView removeFromSuperview];
    //_strongView = nil;从父视图移除后，强引用的视图还未释放，需要置为nil来释放
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkWeakView];
    });
}

#pragma mark -- 强引用和弱引用的区别 ： 03移除上的区别
//重点：涉及到理解强弱指针，执行上述代码后，视图上会出现两个view，点击空白的地方，移除掉两个view，1秒后看下，1秒后看是因为这个方法，运行到结束的括号之后，才会把view移除掉，此时控制台的_weakView = nil;_strongView还是存在的，因为即使从父视图上移除，self本身还是对其还有一个强引用，不会被释放掉，如果想要释放，则在[_strongView removeFromSuperview];之后添加_strongView = nil;
- (void)checkWeakView{
    
    NSLog(@"weakView: %@",_weakView);
    NSLog(@"strongView: %@",_strongView);
}

#pragma mark -- 强引用和弱引用的区别 ： 01写法上的区别
- (UIView *)weakView{
    if (!_weakView) {
        UIView *weakView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _weakView = weakView;
        _weakView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_weakView];
        
        //01、必须使用UIView *weakView = [[UIView alloc] init，不能用_weakView，会报错，等号右边创建了后给了一个弱引用持有，相当于是没有持有，就直接释放了；而等号左边的UIView *weakView默认是一个强引用，会暂时持有保住它，但是生命周期就在这个懒加载的大括号内，所以会有其他代码配合使这个view存活下来，不被释放
        //02、_weakView = weakView;这句代码为赋值操作，基本作用等同于强引用的_strongView = [UIView alloc]init];
        //03、[self.view addSubview:self.weakView];如第一条，给这个view加到一个不会被释放的view上即self.view,使weakView保存下来
    }
    return _weakView;
}

#pragma mark -- 强引用和弱引用的总结
//总结起来的话，如果理解的到位，使用强弱都没有问题，但是一般来说，由于弱引用会被及时释放掉，同时，weak在对象消失后自动把指针变成nil，所以需求允许的化，一般建议使用弱引用；根据需求，如果是一个view从父视图移除后再添加回来，就需要使用强引用
- (UIView *)strongView{
    if (!_strongView) {
        _strongView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 60, 60)];
        _strongView.backgroundColor = [UIColor greenColor];
    }
    return _strongView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
