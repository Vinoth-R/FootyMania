//
//  ViewController.h
//  TrackFooty
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <CAAnimationDelegate , NSXMLParserDelegate>
{
    NSArray *imgArray;
       NSTimer *mytimer;
}
@property (strong, nonatomic) IBOutlet UIImageView *backgroundimgView;
- (IBAction)ballBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ballBtnRotate;



@end

