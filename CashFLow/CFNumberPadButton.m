//
//  CFNumberPadButton.m
//  CashFLow
//
//  Created by Sam Watson on 17/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "CFNumberPadButton.h"

@implementation CFNumberPadButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.originalFrame = frame;
        self.depressedFrame = CGRectInset(frame, 5, 5);
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.originalFrame = frame;
    self.depressedFrame = CGRectInset(frame, 5, 5);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
