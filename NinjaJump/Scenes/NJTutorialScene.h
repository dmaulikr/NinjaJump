//
//  NJTutorialScene.h
//  NinjaJump
//
//  Created by wulifu on 12/4/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//

#import "NJMultiplayerLayeredCharacterScene.h"
#import "NJTuTorialNextButton.h"

@interface NJTutorialScene : NJMultiplayerLayeredCharacterScene <NJTuTorialNextButtonDelegate>

@property (nonatomic) NJTuTorialNextButton *nextButton;

- (instancetype)initWithSizeWithoutSelection:(CGSize)size;

@end