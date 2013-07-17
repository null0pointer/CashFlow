//
//  CFNumberPadButton.m
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "CFNumberPadButton.h"

@implementation CFNumberPadButton

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundView = [[UIView alloc] init];
        self.image = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.image];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)initialiseSubviews {
    self.backgroundView = [[UIView alloc] init];
    self.image = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.image];
    [self addSubview:self.titleLabel];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.originalFrame = self.bounds;
    self.depressedFrame = CGRectInset(self.bounds, 5, 5);
    
    self.backgroundView.frame = self.bounds;
    self.image.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
}

- (void)setTarget:(id)target withSelector:(SEL)selector {
    self.target = target;
    self.targetSelector = selector;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.backgroundView.frame = self.depressedFrame;
    } completion:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.backgroundView.frame = self.originalFrame;
    } completion:nil];
    
    // the touch ended inside the view. aka; a button press
    if (CGRectContainsPoint(self.bounds, [[touches anyObject] locationInView:self])) {
        if (self.target && self.targetSelector) {
            [self.target performSelector:self.targetSelector withObject:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
