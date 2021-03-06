//
//  CFLuxuryEditView.h
//  CashFLow
//
//  Created by Sam Watson on 22/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#define WIDTH 250.0
#define HEIGHT 60.0

#import <UIKit/UIKit.h>

@class CFCoreDataManager;
@class Luxury;

@interface CFLuxuryEditView : UIView

@property (strong, nonatomic)   Luxury             *luxury;
@property (strong, nonatomic)   CFCoreDataManager       *temporaryContext;

@property (strong, nonatomic)   UITextField             *titleField;
@property (strong, nonatomic)   UILabel                 *priceLabel;
@property (strong, nonatomic)   UIButton                *cancelButton;
@property (strong, nonatomic)   UIButton                *saveButton;

@property (strong, nonatomic)   UIImageView             *blurView;
@property (strong, nonatomic)   UIView                  *backgroundView;
@property (strong, nonatomic)   UIView                  *contentView;

- (id)initWithNewLuxury;
- (id)initWithLuxury:(Luxury *)luxury;

- (void)present;
- (void)dismiss;

@end
