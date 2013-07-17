//
//  CFNumberPad.h
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#define CFNUMBERPAD_DEFAULT_WIDTH 270.0
#define CFNUMBERPAD_DEFAULT_HEIGHT 360.0
#define CFNUMBERPAD_DEFAULT_BUTTON_SEPARATION 1.0

#import <UIKit/UIKit.h>

#import "CFNumberPadButton.h"

@class CFNumberPad;

@protocol CFNumberPadDelegate <NSObject>

@optional

- (void)numberPadValueChanged:(CFNumberPad *)numberPad;
- (void)numberPad:(CFNumberPad *)numberPad didEndWithSuccess:(BOOL)success value:(CGFloat)value;

@end

@interface CFNumberPad : UIView

@property (weak, nonatomic)     id<CFNumberPadDelegate> delegate;

@property (nonatomic)           CGFloat                 value;

@property (nonatomic)           CGFloat                 width;
@property (nonatomic)           CGFloat                 height;
@property (nonatomic)           CGFloat                 buttonSeparation;

@property (strong, nonatomic)   UILabel                 *valueLabel;

@property (strong, nonatomic)   NSArray                 *numberButtons;
@property (strong, nonatomic)   CFNumberPadButton       *decimalButton;
@property (strong, nonatomic)   CFNumberPadButton       *clearButton;
@property (strong, nonatomic)   CFNumberPadButton       *cancelButton;
@property (strong, nonatomic)   CFNumberPadButton       *okButton;

@property (strong, nonatomic)   UIImageView             *blurView;
@property (strong, nonatomic)   UIView                  *backgroundView;
@property (strong, nonatomic)   UIView                  *contentView;

- (id)init;
- (id)initWithInitialValue:(CGFloat)value;
- (id)initWithInitialValue:(CGFloat)value width:(CGFloat)width height:(CGFloat)height;
- (id)initWithInitialValue:(CGFloat)value width:(CGFloat)width height:(CGFloat)height buttonSeparation:(CGFloat)buttonSeparation;

- (void)present;
- (void)dismiss;

@end
