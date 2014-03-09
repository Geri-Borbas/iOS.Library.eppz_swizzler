//
//  Human.h
//  eppz!swizzler
//
//  Created by Gardrobe on 3/9/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Human : NSObject


@property (nonatomic, strong) NSString *citizenship;
@property (nonatomic, strong) NSNumber *shoeSize;

-(float)height;
+(float)weight;


@end
