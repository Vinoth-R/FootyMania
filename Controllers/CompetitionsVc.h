//
//  CompetitionsVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 23/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionsVc : UIViewController
{
NSMutableArray *responseArray;
NSArray *idArray;
NSArray *leagueArray;

}
 @property(nonatomic, strong)NSDictionary *jsonObj;

- (void)webServiceHandler;
@end
