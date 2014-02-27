//
//  eppz_swizzlerTests.m
//  eppz!swizzlerTests
//
//  Created by Borbás Geri on 27/02/14
//  Copyright (c) 2013 eppz! development, LLC.
//
//  follow http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <XCTest/XCTest.h>
#import "EPPZSwizzler.h"


@interface Donor : NSObject

-(NSString*)name;

@end


@implementation Donor

-(NSString*)name;
{ return @"Batman"; }

-(NSString*)supermanName
{ return @"Superman"; }

@end


@interface eppz_swizzlerTests : XCTestCase
@end


@implementation eppz_swizzlerTests


-(void)testMethodSwizzlers
{
    [EPPZSwizzler setLogging:YES];
    NSObject *object = [NSObject new];
    Donor *cast = (Donor*)object; // Typecast
    
    
    // Add instance method.
    [EPPZSwizzler addInstanceMethod:@selector(name)
                            toClass:[object class]
                          fromClass:[Donor class]];
    XCTAssertEqualObjects(cast.name, @"Batman",
                          @"addInstanceMethod: should add method `name`");
    
    [EPPZSwizzler addInstanceMethod:@selector(supermanName)
                            toClass:[object class]
                          fromClass:[Donor class]];
    XCTAssertEqualObjects(cast.supermanName, @"Superman",
                          @"addInstanceMethod: should add method `supermanName`");
    
    
    // Swap instance method.
    [EPPZSwizzler swapInstanceMethod:@selector(supermanName)
                  withInstanceMethod:@selector(name)
                             ofClass:[object class]];
    XCTAssertEqualObjects(cast.name, @"Superman",
                          @"addInstanceMethod: should swap method `supermanName` with `name`");
}


@end
