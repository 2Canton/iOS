//
//  CAScheduleDescriptionViewController.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABaseViewController.h"

@interface CAScheduleDescriptionViewController : CABaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) NSString * idRoute;
@property (strong,nonatomic) NSString * idSchedule;

@end
