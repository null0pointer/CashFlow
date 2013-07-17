//
//  CFNumberPad.m
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "CFNumberPad.h"

#import "GPUImage.h"

@implementation CFNumberPad

- (id)init {
    return [self initWithInitialValue:0.0];
}

- (id)initWithInitialValue:(CGFloat)value {
    return [self initWithInitialValue:value width:CFNUMBERPAD_DEFAULT_WIDTH height:CFNUMBERPAD_DEFAULT_HEIGHT];
}

- (id)initWithInitialValue:(CGFloat)value width:(CGFloat)width height:(CGFloat)height {
    return [self initWithInitialValue:value width:width height:height buttonSeparation:CFNUMBERPAD_DEFAULT_BUTTON_SEPARATION];
}

- (id)initWithInitialValue:(CGFloat)value width:(CGFloat)width height:(CGFloat)height buttonSeparation:(CGFloat)buttonSeparation {
    self = [super initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    
    if (self) {
        self.value = value;
        self.width = width;
        self.height = height;
        self.buttonSeparation = buttonSeparation;
        
        self.blurView = [[UIImageView alloc] init];
        self.backgroundView = [[UIView alloc] init];
        self.contentView = [[UIView alloc] init];
        
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.valueLabel = [[UILabel alloc] init];
        [self.valueLabel setText:[NSString stringWithFormat:@"%f", self.value]];
        
        [self initialiseButtons];
        
        [self layout];
    }
    
    return self;
}

- (void)initialiseButtons {
    NSMutableArray *numberButtons = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 10; i++) {
        CFNumberPadButton *numberButton = [[CFNumberPadButton alloc] init];
        numberButton.tag = i;
        [numberButton setTarget:self withSelector:@selector(numberButtonPressed:)];
        [numberButton.titleLabel setText:[NSString stringWithFormat:@"%d", i]];
        numberButton.backgroundView.backgroundColor = [UIColor whiteColor];
        [numberButtons addObject:numberButton];
    }
    
    self.numberButtons = numberButtons;
    
    self.decimalButton = [[CFNumberPadButton alloc] init];
    [self.decimalButton setTarget:self withSelector:@selector(decimalButtonPressed)];
    [self.decimalButton.titleLabel setText:@"."];
    self.decimalButton.backgroundView.backgroundColor = [UIColor whiteColor];
    
    self.clearButton = [[CFNumberPadButton alloc] init];
    [self.clearButton setTarget:self withSelector:@selector(clearButtonPressed)];
    [self.clearButton.titleLabel setText:@"C"];
    self.clearButton.backgroundView.backgroundColor = [UIColor whiteColor];
    
    self.cancelButton = [[CFNumberPadButton alloc] init];
    [self.cancelButton setTarget:self withSelector:@selector(cancelButtonPressed)];
    [self.cancelButton.titleLabel setText:@"Cancel"];
    self.cancelButton.backgroundView.backgroundColor = [UIColor redColor];
    
    self.okButton = [[CFNumberPadButton alloc] init];
    [self.okButton setTarget:self withSelector:@selector(okButtonPressed)];
    [self.okButton.titleLabel setText:@"OK"];
    self.okButton.backgroundView.backgroundColor = [UIColor greenColor];
}

- (void)layout {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    self.frame = keyWindow.bounds;
    
    self.blurView.frame = self.bounds;
    [self addSubview:self.blurView];
    
    self.backgroundView.frame = self.bounds;
    [self addSubview:self.backgroundView];
    
    self.contentView.frame = CGRectIntegral(CGRectMake((self.frame.size.width - self.width) / 2, (self.frame.size.height - self.height) / 2, self.width, self.height));
    [self addSubview:self.contentView];
    
    self.valueLabel.frame = CGRectIntegral(CGRectInset(CGRectMake(0, 0, self.width, self.height / 6), self.buttonSeparation, self.buttonSeparation));
    [self.contentView addSubview:self.valueLabel];
    
    [self layoutButtons];
}

- (void)layoutButtons {
    NSMutableArray *layoutArray = [NSMutableArray arrayWithCapacity:12];
    
    for (int i = 1; i < 10; i++) {
        CFNumberPadButton *button = [self.numberButtons objectAtIndex:i];
        [layoutArray addObject:button];
    }
    
    [layoutArray addObject:self.decimalButton];
    [layoutArray addObject:[self.numberButtons objectAtIndex:0]];
    [layoutArray addObject:self.clearButton];
    
    CGFloat buttonWidth = self.width / 3;
    CGFloat buttonHeight = self.height / 6;
    
    for (int i = 0; i < layoutArray.count; i++) {
        int row = i / 3;
        int column = i % 3;
        
        CFNumberPadButton *button = [layoutArray objectAtIndex:i];
        button.frame = CGRectIntegral(CGRectInset(CGRectMake(column * buttonWidth, buttonHeight + (row * buttonHeight), buttonWidth, buttonHeight), self.buttonSeparation, self.buttonSeparation));
        [self.contentView addSubview:button];
    }
    
    self.cancelButton.frame = CGRectIntegral(CGRectInset(CGRectMake(0, (5 * buttonHeight), buttonWidth, buttonHeight), self.buttonSeparation, self.buttonSeparation));
    [self.contentView addSubview:self.cancelButton];
    
    self.okButton.frame = CGRectIntegral(CGRectInset(CGRectMake(buttonWidth, (5 * buttonHeight), 2 * buttonWidth, buttonHeight), self.buttonSeparation, self.buttonSeparation));
    [self.contentView addSubview:self.okButton];
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

- (void)numberButtonPressed:(CFNumberPadButton *)button {
    
}

- (void)decimalButtonPressed {
    
}

- (void)clearButtonPressed {
    
}

- (void)cancelButtonPressed {
    [self dismiss];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(numberPad: didEndWithSuccess: value:)]) {
            [self.delegate numberPad:self didEndWithSuccess:NO value:self.value];
        }
    }
}

- (void)okButtonPressed {
    [self dismiss];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(numberPad: didEndWithSuccess: value:)]) {
            [self.delegate numberPad:self didEndWithSuccess:YES value:self.value];
        }
    }
}

@end
