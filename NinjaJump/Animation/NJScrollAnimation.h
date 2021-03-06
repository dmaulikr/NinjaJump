//
//  NJScrollAnimation.h
//  NinjaJump
//
//  Created by Wang Yichao on 30/3/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NJNinjaCharacter.h"

@interface NJScrollAnimation : NSObject
- (void) runFireEffect:(NJCharacter *)ninja;
- (void)runFreezeEffect:(NJCharacter *)ninja;
@end