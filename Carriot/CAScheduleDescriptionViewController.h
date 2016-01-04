//
//  CAScheduleDescriptionViewController.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABaseViewController.h"
#import "CARoute.h"
#import "CASchedule.h"

@interface CAScheduleDescriptionViewController : CABaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) CARoute * route;
@property (strong,nonatomic) CASchedule * schedule;

@end
