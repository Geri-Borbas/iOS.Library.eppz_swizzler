//
//  Superhero.h
//  eppz!swizzler
//
//  Created by Gardrobe on 3/8/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Superhero : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *civilianName;

+(NSString*)hometown;
+(NSString*)basetown;

+(NSString*)eyeColor;
+(NSString*)hairColor;

@end
