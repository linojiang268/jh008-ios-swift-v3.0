//
//  UIViewController+MultipleImagePicker.m
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "UIViewController+MultipleImagePicker.h"

@implementation UIViewController (MultipleImagePicker)

/**
 *  展示选择多张图片的控件
 *
 *  @param viewControllerToPresent 多选图片的视图控制器
 *  @param flag                    是否需要显示动画
 *  @param completion              视图出现的回调
 *  @param finishBlock             选择完成图片之后的回调
 */
- (void)presentImagePickerController:(YSQImagePickerViewController *)viewControllerToPresent
                            animated:(BOOL)flag
                          completion:(void (^)(void))completion
                              finish:(FinishSelectImageBlock)finishBlock
{
    if ([viewControllerToPresent isKindOfClass:YSQImagePickerViewController.class]) {
        viewControllerToPresent.finishBlock = finishBlock;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewControllerToPresent];
        [self presentViewController:nav animated:flag completion:completion];
    }
}
@end
