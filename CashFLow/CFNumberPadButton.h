//
//  CFNumberPadButton.h
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFNumberPadButton : UIView

@property (nonatomic)           CGRect      originalFrame;
@property (nonatomic)           CGRect      depressedFrame;

@property (strong, nonatomic)   UIImageView *image;
@property (strong, nonatomic)   UILabel     *titleLabel;

@end
