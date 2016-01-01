//
//  EventCategory.h
//  Carriot
//
//  Created by user on 12/29/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventCategory : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *urlimagen;
@property (nonatomic, retain) NSNumber * cantidad_eventos;

@end
