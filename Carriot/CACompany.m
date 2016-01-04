//
//  CACompany.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CACompany.h"

@implementation CACompany

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
