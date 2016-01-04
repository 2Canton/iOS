//
//  CACompaniesCategory.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CACompaniesCategory.h"

@implementation CACompaniesCategory

- (id) initWithId: (NSString *) pId
             Name: (NSString *) pName
       PictureURL: (NSString *) pPictureURL
      Description: (NSString *) pDescription
{
    if (self = [super init])
    {
        _id = pId;
        _nombre = pName;
        _urlimagen = pPictureURL;
        _descripcion = pDescription;
    }
    
    return self;
}

@end
