//
//  SGHCoreText1ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/22.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHCoreText1ViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"

@interface SGHCoreText1ViewController ()

@property (weak, nonatomic) IBOutlet CTDisplayView *ctView;

@end

@implementation SGHCoreText1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CTFrameParserConfig *config=[[CTFrameParserConfig alloc]init];
    config.textColor=[UIColor redColor];
    config.width=self.ctView.width;
    
    CoreTextData *data=[CTFrameParser parseContent:@"按照以上原则，我们将‘CTDisplayView’中的部分内容拆开。" config:config];
    self.ctView.data=data;
    self.ctView.height=data.height;
    self.ctView.backgroundColor=[UIColor yellowColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
