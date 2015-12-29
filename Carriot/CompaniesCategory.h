//
//  CompaniesCategory.h
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompaniesCategory : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *urlimagen;
@property (nonatomic, retain) NSString *descripcion;

- (id) initWithId: (NSString *) pId
          Name: (NSString *) pName
       PictureURL: (NSString *) pPictureURL
      Description: (NSString *) pDescription;

@end
