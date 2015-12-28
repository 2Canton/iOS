//
//  ScheduleTableViewController.h
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewController : UITableViewController

@property (strong,nonatomic) NSString * idRoute;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
