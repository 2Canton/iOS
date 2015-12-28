//
//  CompaniesTableViewController.h
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompaniesTableViewController : UITableViewController

@property (strong,nonatomic) NSString * idCategory;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
