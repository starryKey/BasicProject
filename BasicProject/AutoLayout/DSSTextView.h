//
//  DSSTextView.h
//  Pods
//
//  Created by Li_JinLin on 17/2/9.
//
//

#import <UIKit/UIKit.h>

@interface DSSTextView : UIView

@property (weak, nonatomic) IBOutlet UITextField *commonTextField;

- (void)chooseImgView:(UIImage *)img;
- (void)controlRightBtn:(BOOL)hidden;
@end
