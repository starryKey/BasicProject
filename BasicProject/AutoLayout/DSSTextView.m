//
//  DSSTextView.m
//  Pods
//
//  Created by Li_JinLin on 17/2/9.
//
//

#import "DSSTextView.h"

@interface  DSSTextView()

@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;


@end

@implementation DSSTextView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
- (IBAction)rightBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.commonTextField.secureTextEntry = NO;
    } else {
        [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.commonTextField.secureTextEntry = YES;
    }
    btn.selected = !btn.selected;
    
}

- (void)chooseImgView:(UIImage *)img{
    self.leftImgView.image = img;
}
- (void)controlRightBtn:(BOOL)hidden{
    if (hidden) {
        self.rightBtn.hidden = YES;
    } else {
        self.rightBtn.hidden = NO;
    }
}

@end
