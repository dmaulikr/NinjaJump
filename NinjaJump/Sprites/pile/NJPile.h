//
//  NJPile.h
//  NinjaJump
//
//  Created by wulifu on 19/3/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NJPath.h"

typedef enum : uint8_t {
    NJDiectionClockwise = 0,
    NJDirectionCounterClockwise
} NJDirection;

@class NJCharacter;

@interface NJPile : SKSpriteNode

@property float radius; //do we really need it?
@property float speed;
@property float angularSpeed;
@property float angleRotatedSinceLastUpdate;
@property NJDirection rotateDirection;
@property NJPath *path; //contains position and path
@property NJCharacter *standingCharacter;
@property BOOL isIceScrollEnabled;
@property BOOL isThunderScrollEnabled;

/* Preload texture */
//+(void)loadSharedAssets;

-(instancetype)initWithTextureNamed:(NSString *)textureName atPosition:(CGPoint)position withSpeed:(float)speed angularSpeed:(float)aSpeed direction:(NJDirection)direction path:(NJPath *)path;

// EFFECTS: Update the next-frame renderring of the pile
- (void)updateWithTimeSinceLastUpdate:(NSTimeInterval)interval;

// EFFECTS: return the position of the pile afte a timeinterval
- (CGPoint)positionAfterTimeinterval:(NSTimeInterval)interval;

- (void)addCharacterToPile:(NJCharacter *)character;
- (void)setSpeed:(float)aSpeed direction:(NJDirection)direction;

- (void)removeStandingCharacter;
@end
