//
//  EventsViewController.h
//  Carriot
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (strong,nonatomic) NSString * idCategory;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
