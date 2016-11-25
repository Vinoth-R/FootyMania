//
//  PremierLeagueVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremierLeagueVc : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSDictionary *jsonObj;
    NSMutableArray *teamsDict;
    NSArray *nameArray;
    NSArray *codeArray;
    NSArray *valueArray;
    NSArray *crestUrlArray;
    NSDictionary *playerDict;
    NSArray *playerArray;
    NSArray *playerHref;

}
@property (strong, nonatomic) NSString *compNo;
@property (strong, nonatomic) IBOutlet UICollectionView *teamCollectionView;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)moreBtnPressed:(id)sender;
@end
