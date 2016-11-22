//
//  RssTableCell.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 11/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *newsLbl;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *pubDateLbl;

@end
