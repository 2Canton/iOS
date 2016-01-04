//
//  CACompanyTableViewCell.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CACompanyTableViewCell.h"

@implementation CACompanyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 15;
    frame.origin.y += 15;
    frame.size.width -= 2 * 15;
    frame.size.height -= 2 * 5;
    [super setFrame:frame];
}

@end
