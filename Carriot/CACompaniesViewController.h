//
//  CACompaniesViewController.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABaseViewController.h"
#import "CACompaniesCategory.h"

@interface CACompaniesViewController : CABaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) CACompaniesCategory * category;

@end
