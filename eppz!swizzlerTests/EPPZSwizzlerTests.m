//
//  EPPZSwizzlerTests.m
//  eppz!swizzlerTests
//
//  Created by Borbás Geri on 3/8/14
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

#import "Superman.h"
#import "Batman.h"
#import "Spiderman.h"
#import "Wolverine.h"
#import "Human.h"


@interface EPPZSwizzlerTests : XCTestCase
@end


@implementation EPPZSwizzlerTests


-(void)setUp
{
    [super setUp];
    [EPPZSwizzler setLogging:YES];
}


#pragma mark - Method swapping

-(void)testInstanceMethodSwapping
{
    Superman *superman = [Superman new];
    
    [EPPZSwizzler swapInstanceMethod:@selector(name) // @"Superman"
                  withInstanceMethod:@selector(civilianName) // @"Clark Kent"
                             ofClass:Superman.class];
    
    XCTAssertEqualObjects([superman name],
                          @"Clark Kent",
                          @"superman `name` should be swizzled for now.");
    
    XCTAssertEqualObjects([superman civilianName],
                          @"Superman",
                          @"superman `civilianName` should be swizzled for now.");
}

-(void)testClassMethodSwapping
{
    [EPPZSwizzler swapClassMethod:@selector(eyeColor) // @"Blue"
                  withClassMethod:@selector(hairColor) // @"Black"
                          ofClass:Superman.class];
    
    XCTAssertEqualObjects([Superman eyeColor],
                          @"Black",
                          @"Superman `eyeColor` should be swizzled for now.");
    
    XCTAssertEqualObjects([Superman hairColor],
                          @"Blue",
                          @"Superman `hairColor` should be swizzled for now.");
}


#pragma mark - Method replacement

-(void)testInstanceMethodReplacement
{
    Spiderman *spiderman = [Spiderman new];
    
    [EPPZSwizzler replaceInstanceMethod:@selector(name)
                                ofClass:Spiderman.class // @"Spiderman"
                              fromClass:Wolverine.class]; // @"Wolverine"
    
    XCTAssertEqualObjects([spiderman name],
                          @"Wolverine",
                          @"spiderman `name` should be swizzled for now.");
}

-(void)testClassMethodReplacement
{
    [EPPZSwizzler replaceClassMethod:@selector(hometown)
                             ofClass:Spiderman.class // @"New York"
                           fromClass:Wolverine.class]; // @"Alberta"
    
    XCTAssertEqualObjects([Spiderman hometown],
                          @"Alberta",
                          @"Spiderman `hometown` should be swizzled for now.");
}


#pragma mark - Add method

-(void)testAddInstanceMethod
{
    Superman *superman = [Superman new];
    Human *human = [Human new];
    
    [EPPZSwizzler addInstanceMethod:@selector(height)
                            toClass:Superman.class
                          fromClass:Human.class];

    XCTAssertEqual([(Human*)superman height], // Supress compiler warning
                   human.height,
                   @"superman `height` should be swizzled for now.");
}

-(void)testAddClassMethod
{
    Superman *superman = [Superman new];
    Class supermanClass = superman.class; // Supress compiler warning
    
    [EPPZSwizzler addClassMethod:@selector(weight)
                         toClass:Superman.class
                       fromClass:Human.class];
    
    XCTAssertEqual([supermanClass weight],
                   [Human weight],
                   @"superman `height` should be swizzled for now.");
}


#pragma mark - Property swizzlings

-(void)testAddProperty
{
    [EPPZSwizzler addPropertyNamed:@"citizenship"
                           toClass:Superhero.class
                         fromClass:Human.class];
    
    Human *spiderman = (Human*)[Spiderman new]; // Supress compiler warning
    
    XCTAssertNoThrow(spiderman.citizenship = @"U.S.A",
                     @"Superhero spiderman should have `citizenship` property added for now.");
    
    XCTAssertEqual(spiderman.citizenship,
                   @"U.S.A",
                   @"spiderman `citizenship` should be set.");
}

-(void)testSynthesizeProperty
{
    [EPPZSwizzler synthesizePropertyNamed:@"shoeSize"
                                   ofKind:[NSNumber class]
                                 forClass:Superhero.class
                               withPolicy:assign];
    
    Human *batman = (Human*)[Batman new]; // Supress compiler warning
    
    XCTAssertNoThrow(batman.shoeSize = @(12),
                     @"Superhero batman should have `shoeSize` property synthesized for now.");
    
    XCTAssertEqualObjects(batman.shoeSize,
                          @(12),
                          @"batman `shoeSize` should be set.");
}


@end
