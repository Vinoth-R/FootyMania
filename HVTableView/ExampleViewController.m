//
//  ExampleViewController.m
//  HVTableView
//
//  Created by ParastooTb on 10/29/2016.
//  Copyright (c) 2016 ParastooTb. All rights reserved.
//

#import "ExampleViewController.h"
#import "ExampleTableViewCell.h"

@interface ExampleViewController () <HVTableViewDataSource, HVTableViewDelegate > {
}

@end

@implementation ExampleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self webServiceHandler];
	// Do any additional setup after loading the view, typically from a nib.
    self.table.HVTableViewDelegate = self;
    self.table.HVTableViewDataSource = self;
     
}

-(void)tableView:(UITableView *)tableView expandCell:(ExampleTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
    
    [UIView animateWithDuration:.5 animations:^{
         [cell.detailLabel setHidden:NO];
         [cell.nationalityLabel setHidden:NO];
         [cell.dobLabel setHidden:NO];
         [cell.marketValueLabel setHidden:NO];
         [cell.dummy1 setHidden:NO];
         [cell.dummy2 setHidden:NO];
         [cell.dummy3 setHidden:NO];
         [cell.dummy4 setHidden:NO];
        
        cell.arrow.transform = CGAffineTransformMakeRotation(0);
    }];
    
}

-(void)tableView:(UITableView *)tableView collapseCell:(ExampleTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
//    UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
//    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
    
    
            cell.arrow.transform = CGAffineTransformMakeRotation(0);
         //   cell.detailLabel.text = @"Lorem ipsum dolor sit ame";
    [cell.detailLabel setHidden:YES];
    [cell.nationalityLabel setHidden:YES];
    [cell.dobLabel setHidden:YES];
    [cell.marketValueLabel setHidden:YES];
    [cell.dummy1 setHidden:YES];
    [cell.dummy2 setHidden:YES];
    [cell.dummy3 setHidden:YES];
    [cell.dummy4 setHidden:YES];
    
    [UIView animateWithDuration:.5 animations:^{

//        detailLabel.text = @"Lorem ipsum dolor sit amet";
        cell.arrow.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0)
    {
    return GkArray.count;
    }
    else if(section==1){
       
        return defArray.count;
    }
    else if(section==2){
       
        return MidArray.count;

    }
    else if(section==3){
     
        return AttArray.count;
    }
    else
    {
        return 1;
    }
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded{
    
    ExampleTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:[ExampleTableViewCell cellIdentifier]];
    
    
    if (indexPath.section==0) {
        
        [self assignCell:cell Array:GkArray IndexPath:indexPath];

    }
    else if (indexPath.section==1)
    {
        
        [self assignCell:cell Array:defArray IndexPath:indexPath];
    }
    else if (indexPath.section==2)
    {
        
        [self assignCell:cell Array:MidArray IndexPath:indexPath];

    }
    else if (indexPath.section==3)
    {
        [self assignCell:cell Array:AttArray IndexPath:indexPath];

    }


    if (!isExpanded) {
        
        [cell.detailLabel setHidden:YES];
        [cell.nationalityLabel setHidden:YES];
        [cell.dobLabel setHidden:YES];
        [cell.marketValueLabel setHidden:YES];
        [cell.dummy1 setHidden:YES];
        [cell.dummy2 setHidden:YES];
        [cell.dummy3 setHidden:YES];
        [cell.dummy4 setHidden:YES];
        cell.arrow.transform = CGAffineTransformMakeRotation(M_PI);
   
    }
    else {
        [cell.detailLabel setHidden:NO];
        [cell.nationalityLabel setHidden:NO];
        [cell.dobLabel setHidden:NO];
        [cell.marketValueLabel setHidden:NO];
        [cell.dummy1 setHidden:NO];
        [cell.dummy2 setHidden:NO];
        [cell.dummy3 setHidden:NO];
        [cell.dummy4 setHidden:NO];
        
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
    if (isexpanded)
        return 150;
    
    return 60;
}


-(void)assignCell:(ExampleTableViewCell *)cell Array:(NSMutableArray *)array IndexPath:(NSIndexPath *)index
{
    cell.titlesLabel.text = [[array objectAtIndex:index.row]valueForKey:@"name"];
    cell.detailLabel.text = [[array objectAtIndex:index.row]valueForKey:@"position"];
    cell.nationalityLabel.text = [[array objectAtIndex:index.row]valueForKey:@"nationality"];
    cell.dobLabel.text = [[array objectAtIndex:index.row]valueForKey:@"dob"];
    if ([[array objectAtIndex:index.row]valueForKey:@"value"]!=[NSNull null]) {
        cell.marketValueLabel.text = [[array objectAtIndex:index.row]valueForKey:@"value"];
    }
    else{
    cell.marketValueLabel.text = @"500,000 €";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    } else {
        
        switch (section)
        {
            case 0:
                sectionName = @"Goal Keepers";
                break;
            case 1:
                sectionName = @"Defenders";
                break;
            case 2:
                sectionName = @"Midfileders";
                break;
                // ...
            case 3:
                sectionName = @"Attackers";
                break;
        }

    }

        return sectionName;
}

- (IBAction)closeBtn:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BallRotate"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webServiceHandler {
    
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_playerUrlStr]];
    
    [myRequest setValue:@"296672553f954624af8893f4aa95b68c" forHTTPHeaderField:@"X-Auth-Token"];
    [myRequest setHTTPMethod:@"GET"];
    
    //[myRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    [[session dataTaskWithRequest:myRequest
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data!=Nil) {
                            
                            NSLog(@"error is %@", error);
                            NSError *error;
                            jsonObj = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:kNilOptions
                                       error:&error];
                            playersArray = [jsonObj objectForKey:@"players"];
                            nameArray = [playersArray valueForKey:@"name"];
                            positionArray = [playersArray valueForKey:@"position"];
                            nationality = [playersArray valueForKey: @"nationality"];
                            marketValue = [playersArray valueForKey:@"marketValue"];
                            dateOfBirth = [playersArray valueForKey:@"dateOfBirth"];
                            
                            GkArray = [[NSMutableArray alloc]init];
                            defArray = [[NSMutableArray alloc]init];
                            MidArray = [[NSMutableArray alloc]init];
                            AttArray = [[NSMutableArray alloc]init];
                            
                            for (int i=0; i<positionArray.count; i++) {
                                
                                
                              
                                if ([positionArray[i] containsString:@"Keeper"]) {
                                    
                                    GkDict =  [NSMutableDictionary dictionary];
                                    [self assignDict:GkDict position:i];
                                    [GkArray addObject: GkDict];
                                    
                                 }
                                else if ([positionArray[i] containsString:@"Back"]) {
                                    
                                    defDict = [NSMutableDictionary dictionary];
                                    [self assignDict:defDict position:i];
                                    [defArray addObject: defDict];
                                    
                                }
                                else if ([positionArray[i] containsString:@"Midfield"]) {
                                    
                                    MidDict = [NSMutableDictionary dictionary];
                                    [self assignDict:MidDict position:i];
                                    [MidArray addObject: MidDict];
                                    
                                 }
                                else  {
                                    
                                    AttDict = [NSMutableDictionary dictionary];
                                    [self assignDict:AttDict position:i];
                                    [AttArray addObject: AttDict];
                                }
                                
                                                             }
                            NSLog(@"response data-->%@",GkDict);
                            NSLog(@"response data-->%@",defDict);

                            NSLog(@"response data-->%@",MidDict);

                            NSLog(@"response data-->%@",AttDict);

                            [_table reloadData];
                            
                            
                        }
                    });
                    
                }] resume];
    
    
}

-(void)assignDict:(NSMutableDictionary *)dict position:(int)i
{
    [dict setValue:nameArray[i] forKey:@"name"];
    [dict setValue:positionArray[i] forKey:@"position"];
    [dict setValue:nationality[i] forKey:@"nationality"];
    [dict setValue:marketValue[i] forKey:@"value"];
    [dict setValue:dateOfBirth[i] forKey:@"dob"];
    


}

@end
