//
//  EventDetailViewController.h
//  Carriot
//
//  Created by user on 12/31/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAEvent.h"

@interface EventDetailViewController : UIViewController

@property (strong,nonatomic) CAEvent * event;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblHour;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;



@end
