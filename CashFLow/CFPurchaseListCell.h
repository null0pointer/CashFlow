//
//  CFPurchaseListCell.h
//  CashFLow
//
//  Created by Sam Watson on 19/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPurchaseListCell : UITableViewCell

@property (strong, nonatomic)   IBOutlet    UILabel         *titleLabel;
@property (strong, nonatomic)   IBOutlet    UIProgressView  *purchaseProgressView;

@end
