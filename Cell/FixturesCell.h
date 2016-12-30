//
//  FixturesCell.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 27/12/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixturesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamOneLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoLbl;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end
