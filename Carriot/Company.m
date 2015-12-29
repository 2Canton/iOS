//
//  Company.m
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "Company.h"

@implementation Company

- (id) initWithId: (NSString *) pId
              Name: (NSString *) pName
           Address: (NSString *) pAddress
          Schedule: (NSString *) pSchedule
        PictureURL: (NSString *) pPictureURL
{
    if (self = [super init])
    {
        _id = pId;
        _nombre = pName;
        _direccion = pAddress;
        _horario = pSchedule;
        _urlimagen = pPictureURL;
        
    }
    
    return self;
}

@end
