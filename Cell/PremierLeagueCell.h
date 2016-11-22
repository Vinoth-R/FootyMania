//
//  PremierLeagueCell.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 07/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremierLeagueCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *clubNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *shortNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *marketValueLbl;
@property (weak, nonatomic) IBOutlet UIButton *BtnBall;



@end
