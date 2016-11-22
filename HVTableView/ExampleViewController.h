//
//  ExampleViewController.h
//  HVTableView
//
//  Created by ParastooTb on 10/29/2016.
//  Copyright (c) 2016 ParastooTb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableView.h"


@interface ExampleViewController : UIViewController 
{

    NSDictionary *jsonObj;
    NSArray *playersArray;
    NSArray *nameArray;
    NSArray *positionArray;
    NSArray *nationality;
    NSArray *marketValue;
    NSArray *dateOfBirth;
    NSMutableDictionary *GkDict;
    NSMutableDictionary *defDict;
    NSMutableDictionary *MidDict;
    NSMutableDictionary *AttDict;
    NSMutableArray *GkArray;
    NSMutableArray *defArray;
    NSMutableArray *MidArray;
    NSMutableArray *AttArray;

    

    
    
}
@property (weak, nonatomic) IBOutlet HVTableView *table;
- (IBAction)closeBtn:(id)sender;
@property (weak, nonatomic) NSString *playerUrlStr;


@end
