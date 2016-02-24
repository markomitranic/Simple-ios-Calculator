//
//  ViewController.m
//  Third Lesson
//
//  Created by Marko Mitranić on 12/15/15.
//  Copyright © 2015 Marko Mitranić. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@property (weak, nonatomic) IBOutlet UIButton *divisionBtn;
@property (weak, nonatomic) IBOutlet UIButton *percentBtn;
@property (weak, nonatomic) IBOutlet UIButton *absoluteBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *multipleBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *equalBtn;
@property (strong, nonatomic) NSNumber *firstNumber;
@property (readwrite, nonatomic) NSInteger pendingOperation;

@end

typedef enum NSInteger {
    ADDITION,
    DIVISION,
    MULTIPLICATION,
    SUBSTRACTION,
    NOTHING
} OperationType;





@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//When a number button is pressed, this function captures it and adds it to display, after checking if the display is 0.
- (IBAction)addNumber:(id)sender {
    if ([_resultLbl.text  isEqual: @"0"]) {
        _resultLbl.text = @"";
    }
    NSString* newValue = [NSString stringWithFormat:@"%@%@", _resultLbl.text, @([sender tag])];
    _resultLbl.text = newValue;
}

//Operational button press captures.
- (IBAction)clearBtn:(id)sender {
    _resultLbl.text = @"0";
    _firstNumber = 0;
    _pendingOperation = NOTHING;
}

- (IBAction)minus:(id)sender {
    _pendingOperation = SUBSTRACTION;
    [self newOperation];
}

- (IBAction)plus:(id)sender {
    _pendingOperation = ADDITION;
    [self newOperation];
}

- (IBAction)multiple:(id)sender {
    _pendingOperation = MULTIPLICATION;
    [self newOperation];
}

//Find 1% of the input number
- (IBAction)percent:(id)sender {
    double tempValue = 0.01 * [_resultLbl.text doubleValue];
    _resultLbl.text = [NSString stringWithFormat:@"%0.2f", tempValue];
}


//Mirror the current absolute value, and display the result
- (IBAction)absolute:(id)sender {
    double tempValue = 0 - [_resultLbl.text doubleValue];
    _resultLbl.text = [NSString stringWithFormat:@"%0.2f", tempValue];
}

//All operations use this to capture the number, and reset the display in preparation for the next command
- (void)newOperation {
    _firstNumber = @([_resultLbl.text doubleValue]);
    _resultLbl.text = @"0";
}

//Decide what operation to use when the result button is pressed.
- (IBAction)result:(id)sender {
    switch (_pendingOperation) {
        case ADDITION:
            [self additionOperation];
            break;
        case SUBSTRACTION:
            [self substractionOperation];
            break;
        case MULTIPLICATION:
            [self multiplyOperation];
            break;
    }
}

-(void)additionOperation {
    double result = _firstNumber.doubleValue + [_resultLbl.text doubleValue];
    [self showResult:result];
}

-(void)substractionOperation {
    double result = _firstNumber.doubleValue - [_resultLbl.text doubleValue];
    [self showResult:result];
}

-(void)multiplyOperation {
    double result = _firstNumber.doubleValue * [_resultLbl.text doubleValue];
    [self showResult:result];
}

//Use this to show result in the display and set the firstNumber to the result.
-(void)showResult:(double)result {
    _resultLbl.text = [NSString stringWithFormat:@"%0.f", result];
    _firstNumber = @(result);
}



@end
