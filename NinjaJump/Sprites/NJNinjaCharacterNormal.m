//
//  NJNinjaCharacterNormal.m
//  NinjaJump
//
//  Created by Wang Kunzhen on 18/3/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//
#define NUM_OF_FRAMES_FOR_NORMAL_NINJA_JUMP 10
#define NUM_OF_FRAMES_FOR_NORMAL_NINJA_DEATH 10

#import "NJNinjaCharacterNormal.h"
#import "NJGraphicsUnitilities.h"

@implementation NJNinjaCharacterNormal
+ (void)loadSharedAssets
{
    [super loadSharedAssets];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sSharedJumpAnimationFrames = [NJGraphicsUnitilities NJLoadFramesFromAtlas:@"Ninja_Jump" withBaseName:@"ninja_jump" andNumOfFrames:NUM_OF_FRAMES_FOR_NORMAL_NINJA_JUMP];
        //sSharedDeathAnimationFrames = [NJGraphicsUnitilities NJLoadFramesFromAtlas:@"ninja_normal_death" withBaseName:@"ninja_death_atlas_" andNumOfFrames:NUM_OF_FRAMES_FOR_NORMAL_NINJA_DEATH];
    });
}

static NSArray *sSharedJumpAnimationFrames;
- (NSArray *)jumpAnimationFrames
{
    return sSharedJumpAnimationFrames;
}

static NSArray *sSharedDeathAnimationFrames;
- (NSArray *)deathAnimationFrames
{
    return sSharedDeathAnimationFrames;
}

@end
