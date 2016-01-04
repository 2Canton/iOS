//
//  CAOption.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAOption.h"

@implementation CAOption

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
