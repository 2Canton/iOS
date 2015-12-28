//
//  RoutePathTableViewController.h
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoutePathTableViewController : UITableViewController

@property (strong,nonatomic) NSString * idRoute;
@property (strong,nonatomic) NSString * idSchedule;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
