//
//  UIViewController+MultipleImagePicker.h
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSQImagePickerViewController.h"

@interface UIViewController (MultipleImagePicker)

- (void)presentImagePickerController:(YSQImagePickerViewController *)viewControllerToPresent
                            animated:(BOOL)flag
                          completion:(void (^)(void))completion
                              finish:(FinishSelectImageBlock)finishBlock;
@end
