//
//  CompaniesCategory.m
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "CompaniesCategory.h"

@implementation CompaniesCategory

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
