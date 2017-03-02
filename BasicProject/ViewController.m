//
//  ViewController.m
//  BasicProject
//
//  Created by Li_JinLin on 17/2/6.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

//磁盘剩余空间
//+ (double)freeDiskSpaceInMBytes
//{
//    struct statfs buf;
//    long long freespace = -1;
//    if(statfs("/var", &buf) >= 0)
//    {
//        freespace = (long long)(buf.f_bsize * buf.f_bfree);
//    }
//    return freespace/(1024.0*1024.0);
//}

#import "ViewController.h"
#import <objc/Object.h>
#import <objc/runtime.h>
@interface ViewController ()

@property (nonatomic, weak)   UIView    *weakView;
@property (nonatomic, strong) UIView    *strongView;
@property (nonatomic, copy)   NSString  *str;
@property (nonatomic, assign) NSInteger nCount;
@property (atomic, copy)NSString *testStr;
//用Objective-C等面向对象语言编程时，‘对象’（object）就是“基本构造单元”，开发者可以通过对象来存储并传递数据，在对象之间传递数据并执行任务的过程就叫消息传递，当程序运行起来后，为其提供相关支持的代码叫做“Objective-C运行期环境”（Objective-C runtime）,它提供了一些使得对象之间能够传递消息的重要函数，并且包含创建类实例使用的全部逻辑。

//assign  '设置方法' 只会执行针对‘纯量类型’的简单赋值操作
//strong  此特质表明该属性定义了一种“拥有关系”，为这种属性设置新值时，设置方法会先保留新值，并释放旧值，然后再将新值设置上去
//weak    此特质表明该属性定义了一种“非拥有关系”，为这种属性设置新值时，设置方法既不保留新值，也不会释放旧值。此特质同assign类似，然而在属性所指的对象遭到摧毁时，属性值也会清空
//copy    此特质所表达的所属关系与strong类似。然而设置方法并不保留新值，而是将其拷贝（copy）。当属性类型为NSString * 时，经常使用此特质来保护其封装性，因为传递给设置方法的新值有可能指向一个NSMutableString类的实例，这个类是NSString的子类，表示一种可以修改其值得字符串，此时若是不拷贝字符串，那么设置完属性后，字符串的值就可能会在对象不知情的情况下遭人修改。所以这时就要拷贝一份“不可变”的字符串，确保对象中的字符串值不会无意间变动。只要实现属性所用的对象是“可变的”，就应该在设置新属性值时拷贝一份。
@end

@implementation ViewController


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
/*
 
 @protocol TJXViewDelegate<NSObject>
 //判断点击的那个
 -(void)sendImageName:(TJXView *)TJXView andName:(NSInteger)selectImage;
 @end
 @interface TJXView : UIView
 @property (nonatomic,weak)id<TJXViewDelegate>delegate;
 //传一个frame 和 装有图片名字的数组过来
 //参数一：frame
 //参数二：装有图片名字的数组
 //参数三：BOOL如果是YES，那么自动滚动，如果是NO不滚动
 -(id)initWithFrame:(CGRect)frame andImageNameArray:
 (NSMutableArray * )imageNameArray andIsRunning:(BOOL)isRunning;
 @end
 .m文件
 
 @interface TJXView()<UIScrollViewDelegate>
 {
 NSInteger _currentPage; //记录真实的页码数
 NSTimer *_timer;  //生命一个全局变量
 }
 @property (nonatomic,assign) BOOL isRun;
 @property (nonatomic,strong) NSMutableArray *imageArray;//存储图片的名字
 @property (nonatomic,strong) UIScrollView *scrollView;
 @property (nonatomic,strong) UIPageControl *pageControl;
 @property (nonatomic,assign) CGFloat width;//view的宽
 @property (nonatomic,assign) CGFloat height;//view的高
 @end
 
 、、、
 
 -(id)initWithFrame:(CGRect)frame andImageNameArray:(NSMutableArray *)imageNameArray andIsRunning:(BOOL)isRunning{
 self = [super initWithFrame:frame];
 if (self) {
 _width = self.frame.size.width;
 _height = self.frame.size.height;
 //arrayWithArray 把数组中的内容放到一个数组中返回
 self.imageArray = [NSMutableArray arrayWithArray:imageNameArray];
 //在数组的尾部添加原数组第一个元素
 [self.imageArray addObject:[imageNameArray firstObject]];
 //在数组的首部添加原数组最后一个元素
 [self.imageArray insertObject:[imageNameArray lastObject] atIndex:0];
 self.isRun = isRunning;
 _currentPage = 0;
 [self createSro];
 [self createPageControl];
 [self createTimer];
 }
 return self;
 }
 
 、、、
 -(void)createTimer{
 if (_isRun == YES) {
 _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES ];
 [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];    }
 }
 -(void)change{
 //1获得当前的点
 CGPoint point = _scrollView.contentOffset;
 //2求得将要变换的点
 CGPoint endPoint = CGPointMake(point.x+_width, 0);
 //判断
 if (endPoint.x == (self.imageArray.count-1)*_width) {
 [UIView animateWithDuration:0.25 animations:^{
 _scrollView.contentOffset = CGPointMake(endPoint.x, 0);
 } completion:^(BOOL finished) {
 //动画完成的block
 _scrollView.contentOffset = CGPointMake(_width, 0);
 CGPoint realEnd = _scrollView.contentOffset;
 //取一遍页码数
 _currentPage = realEnd.x/_width;
 _pageControl.currentPage = _currentPage-1;
 }];
 }
 else{
 //0.25s中更改一个图片
 [UIView animateWithDuration:0.25 animations:^{
 _scrollView.contentOffset = endPoint;
 } completion:^(BOOL finished) {
 }];
 CGPoint realEnd = _scrollView.contentOffset;
 //取一遍页码数
 _currentPage = realEnd.x/_width;
 _pageControl.currentPage = _currentPage-1;
 }
 }
 //创建页码指示器
 -(void)createPageControl{
 _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_width-200, _height-30, 100, 30)];
 _pageControl.centerX = _width/2;
 _pageControl.numberOfPages = self.imageArray.count-2;
 _pageControl.pageIndicatorTintColor = WP_GRAY_COLOR;
 _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
 _pageControl.userInteractionEnabled = NO;
 [self addSubview:_pageControl];
 }
 //创建滚动视图
 -(void)createSro{
 _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
 _scrollView.contentSize = CGSizeMake(_width*self.imageArray.count, _height);
 for (int i = 0; i < self.imageArray.count; i++) {
 UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_width, 0, _width, _height)];
 //        imageView.image = [UIImage imageNamed:self.imageArray[i]];
 [imageView sd_setImageWithURL:self.imageArray[i] placeholderImage:[UIImage imageNamed:@"home_banner_blank"]];
 imageView.userInteractionEnabled = YES;
 imageView.tag = 200+i;
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
 [imageView addGestureRecognizer:tap];
 [_scrollView addSubview:imageView];
 }
 //水平指示条不显示
 _scrollView.showsHorizontalScrollIndicator = NO;
 //关闭弹簧效果
 _scrollView.bounces = NO;
 //设置用户看到第一张
 _scrollView.contentOffset = CGPointMake(_width, 0);
 //设置代理
 _scrollView.delegate = self;
 //分页效果
 _scrollView.pagingEnabled = YES;
 [self addSubview:_scrollView];
 }
 -(void)tap:(UITapGestureRecognizer *)tap{
 if(_delegate&&[_delegate respondsToSelector:@selector(sendImageName:andName:)]){
 [_delegate sendImageName:self andName:tap.view.tag-201];
 }else{
 NSLog(@"没有设置代理或者没有事先协议的方法");
 }
 }
 #pragma mark UIScrollViewDelegate
 //停止滚动
 -(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 if (_timer) {
 [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
 }
 //图片的个数  1 2 3 4 5 6 7 8
 //真实的页码  0 1 2 3 4 5 6 7
 //显示的页码    0 1 2 3 4 5
 CGPoint point = _scrollView.contentOffset;
 if (point.x == (self.imageArray.count-1)*_width) {
 scrollView.contentOffset = CGPointMake(_width, 0);
 }
 if (point.x == 0) {
 scrollView.contentOffset = CGPointMake((self.imageArray.count-2)*_width, 0);
 }
 //取一遍页码数
 CGPoint endPoint = scrollView.contentOffset;
 _currentPage = endPoint.x/_width;
 _pageControl.currentPage = _currentPage-1;
 }
 //手指开始触摸的时候，停止计时器
 -(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
 if (_timer) {
 //如果有，停掉
 [_timer setFireDate:[NSDate distantFuture]];
 }
 }
 在项目中  导入头文件  遵守代理
 TJXView * TJXView = [[TJXView alloc]initWithFrame:CGRectMake(0, 0, WPSCREEN_WIDTH, 100*WPSCREEN_HIGTH_RATIO) andImageNameArray:self.bannerImager andIsRunning:YES];
 TJXView.delegate = self;
 [self.view addSubview: TJXView];
 #pragma mark TJXViewDelegate
 -(void)sendImageName:(TJXView *) TJXView andName:(NSInteger)selectImage{
 KKLog(@"%ld",(long)selectImage);
 }
 
 
 */


@end
