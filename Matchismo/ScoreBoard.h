//
//  ScoreBoard.h
//  Matchismo
//
//  Created by Colin Smith on 1/14/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreBoard : NSObject

@property (strong, nonatomic) NSString *cardsDidMatchUpdate;
@property (nonatomic, strong) NSString *updatedScoreInformation;

- (void) addCardContentsToUpdateInformation:(NSString *)cardContents;

@end
