//
//  CAEventDetailViewController.h
//  Carriot
//
//  Created by user on 1/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAEvent.h"

@interface CAEventDetailViewController : UIViewController

@property (strong,nonatomic) CAEvent * event;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblHour;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end
