//
//  ExampleTableViewCell.h
//  HVTableView
//
//  Created by Parastoo Tabatabayi on 10/29/16.
//  Copyright © 2016 ParastooTb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleTableViewCell;

@protocol ExampleTableViewCellDelegate <NSObject>

-(void)ExampleTableViewCellDidTapPurchaseButton:(ExampleTableViewCell*)cell;

@end

@interface ExampleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dobLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketValueLabel;


@property (weak, nonatomic) IBOutlet UILabel *dummy1;
@property (weak, nonatomic) IBOutlet UILabel *dummy2;
@property (weak, nonatomic) IBOutlet UILabel *dummy3;
@property (weak, nonatomic) IBOutlet UILabel *dummy4;





@property (weak, nonatomic) IBOutlet UIImageView *arrow;


@property (weak, nonatomic) id<ExampleTableViewCellDelegate> delegate;


+(NSString*)cellIdentifier;

@end
