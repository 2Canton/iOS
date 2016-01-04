//
//  CAEventCategory.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAEventCategory : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *urlimagen;
@property (nonatomic, retain) NSNumber * cantidad_eventos;

@end
