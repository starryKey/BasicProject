//
//  TestTableViewController.m
//  BasicProject
//
//  Created by Li_JinLin on 17/3/9.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

#import "TestTableViewController.h"

static NSString *cellID = @"cellID";
@interface TestTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *favTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favTableView.delegate = self;
    self.favTableView.dataSource = self;
    _dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"device_favorites_n.png"];
    cell.textLabel.text = @"收藏夹A";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"favorite_next_n.png"]];
    cell.accessoryView = imgView;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellAccessoryDisclosureIndicator;
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

////TableView编辑模式
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewRowAction *rowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"重命名" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"重命名");
//        
//       
//        
//    }];
//     rowAction1.backgroundColor = [UIColor greenColor];
//    UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"删除");
//        [self.dataArr removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }];
//    
//    NSArray *arr = @[rowAction1,rowAction2];
//    return arr;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *arr = @[indexPath];
       
        [self.dataArr removeObjectAtIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma - mark - 跳转至通用页面
//-(void)onOkButtonClick
//{
//    
//    //进入设置页面，iOS10以后使用私有方法
//    NSString *versionStr = [UIDevice currentDevice].systemVersion;
//    NSInteger nInt = [versionStr integerValue];
//    if (nInt >= 10) {
//        NSString * defaultWork = [self getDefaultWork];
//        NSString * settingMethod = [self getSettingMethod];
//        NSURL*url=[NSURL URLWithString:@"Prefs:root=TETHERING"];
//        Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
//        [[LSApplicationWorkspace  performSelector:NSSelectorFromString(defaultWork)] performSelector:NSSelectorFromString(settingMethod) withObject:url withObject:nil];
//    } else {
//        NSURL *url = [NSURL URLWithString:@"Prefs:root=General&path=About"];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        } else {
//            NSLog(@"未能进入关于页面");
//        }
//    }
//}
//
//-(NSString *) getDefaultWork{
//    NSData *dataOne = [NSData dataWithBytes:(unsigned char []){0x64,0x65,0x66,0x61,0x75,0x6c,0x74,0x57,0x6f,0x72,0x6b,0x73,0x70,0x61,0x63,0x65} length:16];
//    NSString *method = [[NSString alloc] initWithData:dataOne encoding:NSASCIIStringEncoding];
//    return method;
//}
//
//-(NSString *) getSettingMethod{
//    NSData *dataOne = [NSData dataWithBytes:(unsigned char []){0x6f, 0x70, 0x65, 0x6e, 0x53, 0x65, 0x6e, 0x73, 0x69,0x74, 0x69,0x76,0x65,0x55,0x52,0x4c} length:16];
//    NSString *keyone = [[NSString alloc] initWithData:dataOne encoding:NSASCIIStringEncoding];
//    NSData *dataTwo = [NSData dataWithBytes:(unsigned char []){0x77,0x69,0x74,0x68,0x4f,0x70,0x74,0x69,0x6f,0x6e,0x73} length:11];
//    NSString *keytwo = [[NSString alloc] initWithData:dataTwo encoding:NSASCIIStringEncoding];
//    NSString *method = [NSString stringWithFormat:@"%@%@%@%@",keyone,@":",keytwo,@":"];
//    return method;
//}


@end
