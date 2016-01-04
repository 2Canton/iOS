//
//  CAScheduleDescriptionTableViewCell.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAScheduleDescriptionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblHour;
@property (weak, nonatomic) IBOutlet UILabel *lblNote;

@end
