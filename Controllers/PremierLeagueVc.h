//
//  PremierLeagueVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExampleViewController.h"
#import "FixturesVc.h"

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
    NSIndexPath *tappedIP;

}
@property (strong, nonatomic)ExampleViewController *Exvc;
@property (strong, nonatomic)FixturesVc *FixVc;
@property (strong, nonatomic) NSString *compNo;
@property (strong, nonatomic) NSString *compName;
@property (strong, nonatomic) IBOutlet UICollectionView *teamCollectionView;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)moreBtnPressed:(id)sender;
@end
