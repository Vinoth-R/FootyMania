//
//  clubDetailVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 08/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clubDetailVc : UIViewController<UIWebViewDelegate>
{
UIActivityIndicatorView *indicator;

}

@property(strong,nonatomic)NSString *club_name;
- (IBAction)backBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UINavigationBar *nav;
@property (strong, nonatomic) NSString *playerURL;

- (IBAction)playerBtn:(id)sender;




@end
