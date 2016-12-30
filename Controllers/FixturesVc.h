//
//  FixturesVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 27/12/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixturesVc : UIViewController
{
    NSArray *fixturesArray;
    NSArray *HomeTeamArray;
    NSArray *AwayTeamArray;
    NSArray *MatchDay;
    NSArray *status;
    NSArray *results;
    NSArray *HomeScore;
    NSArray *AwayScore;
    NSMutableArray *AwayMutArray;

}
@property (weak, nonatomic) IBOutlet UITableView *fixturesTable;
@property(nonatomic, strong)NSDictionary *jsonObj;

- (void)webServiceHandler;
@end
