//
//  EventTableViewController.h
//  Carriot
//
//  Created by user on 12/29/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewController : UITableViewController

@property (strong,nonatomic) NSString * idCategory;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
