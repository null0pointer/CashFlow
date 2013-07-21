//
//  CFSavingsGoalEditView.m
//  CashFLow
//
//  Created by Sam Watson on 22/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "CFSavingsGoalEditView.h"

#import "CFCoreDataManager.h"
#import "GPUImage.h"
#import "SavingsGoal.h"

@implementation CFSavingsGoalEditView

- (id)initWithNewSavingsGoal {
    self = [super init];
    if (self) {
        self.temporaryContext = [CFCoreDataManager temporaryContext];
        self.savingsGoal = [self.temporaryContext newSavingsGoal];
        
        [self initialiseSubviews];
        [self layout];
    }
    return self;
}

- (id)initWithSavingsGoal:(SavingsGoal *)savingsGoal {
    self = [super init];
    if (self) {
        self.temporaryContext = [CFCoreDataManager temporaryContext];
        self.savingsGoal = (SavingsGoal *)[self.temporaryContext objectWithID:savingsGoal.objectID];
        
        [self initialiseSubviews];
        
        self.titleField.text = self.savingsGoal.title;
        self.priceLabel.text = [NSString stringWithFormat:@"%g", [self.savingsGoal.price floatValue]];
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        
        [self layout];
    }
    return self;
}

- (void)initialiseSubviews {
    self.blurView = [[UIImageView alloc] init];
    self.backgroundView = [[UIView alloc] init];
    self.contentView = [[UIView alloc] init];
    
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.contentView.layer.masksToBounds = NO;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowOpacity = 0.8;
    
    self.titleField = [[UITextField alloc] init];
    self.titleField.backgroundColor = [UIColor clearColor];
    self.titleField.borderStyle = UITextBorderStyleNone;
    self.titleField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    self.titleField.placeholder = @"Enter a title";
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor lightTextColor];
    self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    self.priceLabel.text = @"Enter a price";
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    [self.saveButton setTitle:@"Create" forState:UIControlStateNormal];
}

- (void)layout {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    self.frame = keyWindow.bounds;
    
    self.blurView.frame = self.bounds;
    [self addSubview:self.blurView];
    
    self.backgroundView.frame = self.bounds;
    [self addSubview:self.backgroundView];
    
    self.contentView.frame = CGRectMake((self.frame.size.width - WIDTH) / 2, (self.frame.size.height - HEIGHT) / 2, WIDTH, HEIGHT);
    [self addSubview:self.contentView];
    
    self.titleField.frame = CGRectMake(0, 0, WIDTH, HEIGHT / 3);
    self.priceLabel.frame = CGRectMake(0, HEIGHT / 3, WIDTH, HEIGHT / 3);
    self.cancelButton.frame = CGRectMake(0, 2 * HEIGHT / 3, WIDTH / 2, HEIGHT / 3);
    self.saveButton.frame = CGRectMake(WIDTH / 2, 2 * HEIGHT / 3, WIDTH / 2, HEIGHT / 3);
    
    [self.contentView addSubview:self.titleField];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.saveButton];
}

- (void)present {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContextWithOptions(keyWindow.frame.size, YES, 1.0);
    [keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    GPUImageFastBlurFilter *blurFilter = [[GPUImageFastBlurFilter alloc] init];
    blurFilter.blurPasses = 5;
    UIImage *processedImage = [blurFilter imageByFilteringImage:layerImage];
    
    [self.blurView setImage:processedImage];
    
    self.alpha = 0.0;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
