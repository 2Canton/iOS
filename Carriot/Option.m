//
//  Option.m
//  Carriot
//
//  Created by user on 12/26/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "Option.h"

@implementation Option

- (id) initWithTitle: (NSString *) title
          PictureURL: (NSString *) pictureURL
{
    
    if (self = [super init])
    {
        _title = title;
        _image = pictureURL;
    }
    
    return self;
}

@end
