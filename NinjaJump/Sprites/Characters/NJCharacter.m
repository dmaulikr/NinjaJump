//
//  NJCharacter.m
//  NinjaJump
//
//  Created by Wang Kunzhen on 15/3/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//

#define FULL_HP 100

#import "NJCharacter.h"
#import "NJSpecialItem.h"
#import "NJMultiplayerLayeredCharacterScene.h"
#import "NJGraphicsUnitilities.h"

@implementation NJCharacter

-(instancetype)initWithTextureNamed:(NSString *)textureName AtPosition:(CGPoint)position
{
    self = [super initWithImageNamed:textureName];
    if (self) {
        self.position = position;
        self.movementSpeed = 800;
        self.animationSpeed = 1/60.0f;
        self.health = FULL_HP;
        self.originalTexture = [SKTexture textureWithImageNamed:textureName];
    }
    
    return self;
}

- (void)jumpToPosition:(CGPoint)position fromPosition:(CGPoint)from withTimeInterval:(NSTimeInterval)timeInterval
{
    self.requestedAnimation = NJAnimationStateJump;
    self.animated = YES;
    CGPoint curPosition = self.position;
    CGFloat dx = position.x - curPosition.x;
    CGFloat dy = position.y - curPosition.y;
    CGFloat dt = self.movementSpeed * timeInterval;
    CGFloat distRemaining = hypotf(dx, dy);
    
    CGFloat ang = NJ_POLAR_ADJUST(NJRadiansBetweenPoints(position, curPosition));
    self.zRotation = ang;
    if (distRemaining <= dt) {
        self.position = position;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }
}

- (void)updateWithTimeSinceLastUpdate:(NSTimeInterval)interval
{
    if (self.isAnimated) {
        [self resolveRequestedAnimation];
    }
}

#pragma mark - Attack
- (void)attackCharacter:(NJCharacter *)character
{
    if (character) {
        NSLog(@"reset");
        [character applyDamage:20];
        self.requestedAnimation = NJAnimationStateAttack;
        self.texture = self.originalTexture;
    }
}

#pragma mark - Death
- (void)performDeath
{
    self.health = 0.0f;
    self.dying = YES;
    self.requestedAnimation = NJAnimationStateDeath;
    self.alpha = 0;
}

#pragma mark - Damage
- (BOOL)applyDamage:(CGFloat)damage
{
    self.health -= damage;
    if (self.health > 0.0f) {
//        MultiplayerLayeredCharacterScene *scene = [self characterScene];
//        
//        // Build up "one shot" particle.
//        SKEmitterNode *emitter = [[self damageEmitter] copy];
//        if (emitter) {
//            [scene addNode:emitter atWorldLayer:APAWorldLayerAboveCharacter];
//            
//            emitter.position = self.position;
//            NJRunOneShotEmitter(emitter, 0.15f);
//        }
        
        // Show the damage.
//        SKAction *damageAction = [self damageAction];
//        if (damageAction) {
//            [self runAction:damageAction];
//        }
        return NO;
    }else{
        [self performDeath];
        return YES;
    }
}

#pragma mark - Resets
- (void)resetToPosition:(CGPoint)position
{
    self.position = position;
    SKSpriteNode *spawnEffect = [[SKSpriteNode alloc] initWithImageNamed:@"spawnLight"];
    spawnEffect.color = [SKColor yellowColor];
    spawnEffect.colorBlendFactor = 4.0;
    [self addChild:spawnEffect];
    SKAction *blink = [SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:0.25],[SKAction fadeAlphaTo:0.4 duration:0.25]]];
    [spawnEffect runAction:[SKAction sequence:@[[SKAction repeatAction:blink count:4],[SKAction removeFromParent]]]];
}

#pragma mark - Animation
- (void)resolveRequestedAnimation
{
    NSString *animationKey = nil;
    NSArray *animationFrames = nil;
    NJAnimationState animationState = self.requestedAnimation;
    
    switch (animationState) {
        case NJAnimationStateJump:
            animationKey = @"anim_jump";
            animationFrames = [self jumpAnimationFrames];
            break;
        case NJAnimationStateDeath:
            animationKey = @"anim_death";
            animationFrames = [self deathAnimationFrames];
            break;
        case NJAnimationStateAttack:
            animationKey = @"anim_attack";
            animationFrames = [self attackAnimationFrames];
            break;
        default:
            break;
    }
    
    if (animationKey) {
        [self fireAnimationForState:animationState usingTextures:animationFrames withKey:animationKey];
    }
}

- (void)fireAnimationForState:(NJAnimationState)animationState usingTextures:(NSArray *)animationFrames withKey:(NSString *)animationKey
{
    SKAction *animAction = [self actionForKey:animationKey];
    if (animAction || [animationFrames count] < 1) {
        return; // we already have a running animation or there aren't any frames to animate
    }
    
    self.activeAnimationKey = animationKey;
    [self runAction:[SKAction sequence:@[
                                         [SKAction animateWithTextures:animationFrames timePerFrame:self.animationSpeed resize:YES restore:YES],
                                         [SKAction runBlock:^{
        [self animationHasCompleted:animationState];
    }]]] withKey:animationKey];
}

- (void)animationHasCompleted:(NJAnimationState)animationState
{
        self.animated = NO;
        self.activeAnimationKey = nil;
}

- (void)addToScene:(NJMultiplayerLayeredCharacterScene *)scene
{
    [scene addNode:self atWorldLayer:NJWorldLayerCharacter];
}

#pragma mark - Shared Assets
+ (void)loadSharedAssets {
    // overridden by subclasses
}

#pragma mark - Abstract Methods
- (NSArray *)jumpAnimationFrames
{
    // overridden by subclasses
    return nil;
}

- (NSArray *)deathAnimationFrames
{
    // overridden by subclasses
    return nil;
}

- (NSArray *)attackAnimationFrames
{
    // overridden by subclasses
    return nil;
}

- (SKAction *)damageAction
{
    // overridden by subclasses
    return nil;
}
@end