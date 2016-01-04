//
//  CACompaniesCategory.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACompaniesCategory : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *urlimagen;
@property (nonatomic, retain) NSString *descripcion;

- (id) initWithId: (NSString *) pId
             Name: (NSString *) pName
       PictureURL: (NSString *) pPictureURL
      Description: (NSString *) pDescription;

@end
