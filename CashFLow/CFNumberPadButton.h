//
//  CFNumberPadButton.h
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFNumberPadButton : UIView

@property (weak, nonatomic)     id                              target;
@property (nonatomic)           SEL                             targetSelector;

@property (nonatomic)           CGRect                          originalFrame;
@property (nonatomic)           CGRect                          depressedFrame;

@property (strong, nonatomic)   UIView                          *backgroundView;
@property (strong, nonatomic)   UIImageView                     *image;
@property (strong, nonatomic)   UILabel                         *titleLabel;

- (void)setTarget:(id)target withSelector:(SEL)selector;

@end
