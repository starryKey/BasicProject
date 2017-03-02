//
//  AutoLayoutViewController.m
//  BasicProject
//
//  Created by Li_JinLin on 17/2/9.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

#import "AutoLayoutViewController.h"

/*
 在创建视图的同时给出其相对父视图的“对其方式与缩放系数”，即autoresizingMask
 自动布局(Auto Layout)和布局约束(Layout Constraint)
 自动布局的原理：自动布局是对autoresizingMask的进一步改进，它允许开发者在界面上的任意两个视图之间建立精确的线性变化规则，所谓的线性变化就是数学中的一次函数，即：
 y = m*x + c;
    其中x 和 y是界面中任意两个视图的某个布局属性，m为比例系数，c为常量，每个线性变化规则称之为布局约束Layout Constraint
 
 添加自动布局约束有以下几种方式
 1、使用Xcode的Interface Builder界面设计器添加并设置约束
 2、通过系统原生的NSLayoutConstraint逐条添加约束
 3、通过可视化格式语言VFL添加约束
 4、使用第三方类库（如Masonry）添加约束
 
 */
@interface AutoLayoutViewController ()

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
