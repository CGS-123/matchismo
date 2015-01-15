//
//  ViewController.m
//  Matchismo
//
//  Created by Colin Smith on 1/8/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) Deck *deck;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *updatedMatchInformationLabel;
@end

@implementation ViewController

- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    self.game.numberOfCardsFlipped++;
    if (self.game.threeCardGame) {
        [self.game chooseCardAtIndexThreeCards:cardIndex];
    } else {
        [self.game chooseCardAtIndexTwoCards:cardIndex];
    }
    [self updateUI];
    [self.gameModeSwitch setEnabled:NO];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState: UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.updatedMatchInformationLabel.text = self.game.updatedScoreInformation;
}

- (NSString *)titleForCard: (Card *)card
{
    return card.isChosen || card.isMatched ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen || card.isMatched ? @"cardFront" : @"cardBack"];
}

- (IBAction)redealCardsStartNewGame:(UIButton *)sender
{
    self.game = [self createNewGame];
    [self.gameModeSwitch setEnabled:YES];
    [self checkWhetherThreeCardGameModeOrTwoCardGameMode];
    [self updateUI];


   
}

- (void) checkWhetherThreeCardGameModeOrTwoCardGameMode {
    if (self.gameModeSwitch.on) {
        self.game.threeCardGame = YES;
        self.game.numberOfCardsFlipped = 0;
    } else {
        self.game.threeCardGame = NO;
    }
}

- (CardMatchingGame *) createNewGame
{
     CardMatchingGame *newGame = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return newGame;
}

- (IBAction)UISwitchChangeGameModeToTwoOrThreeCards:(UISwitch *)sender {
    [self checkWhetherThreeCardGameModeOrTwoCardGameMode];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.gameModeSwitch setEnabled:NO];
    [self.gameModeSwitch setOn:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
