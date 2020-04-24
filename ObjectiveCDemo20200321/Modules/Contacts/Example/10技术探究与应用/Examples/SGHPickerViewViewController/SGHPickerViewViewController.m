//
//  SGHPickViewViewController.m
//  UIDatePickerDemo
//
//  Created by huangaengoln on 16/2/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHPickerViewViewController.h"

@interface SGHPickerViewViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UILabel *fruitLabel;
@property(nonatomic,strong)UILabel *stapleLabel;
@property(nonatomic,strong)UILabel *drinkLabel;
@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *foodsArray;

@end

@implementation SGHPickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    [self setUpUI];
    
    for (NSInteger component = 0; component<self.foodsArray.count; component++) {
        [self pickerView:nil didSelectRow:1 inComponent:component];
    }
    
}
-(NSArray *)foodsArray {
    if (_foodsArray==nil) {
        NSString *fullpath=[[NSBundle mainBundle]pathForResource:@"foods.plist" ofType:nil];
        NSArray *arrayM=[NSArray arrayWithContentsOfFile:fullpath];
        _foodsArray=arrayM;
    }
    return _foodsArray;
}

-(void)setUpUI {
    self.pickerView = ({
        UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 110, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/2)];
        pickerView.backgroundColor=[UIColor whiteColor];
        pickerView.delegate=self;
        pickerView.dataSource=self;
        [self.view addSubview:pickerView];
        pickerView;
    });
    
    UIButton *randomButton =({
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(20, 70, 60, 30);
        button.backgroundColor=[UIColor whiteColor];
        [button setTitle:@"随机" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(randomFood:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    self.fruitLabel =({
        UILabel *label=[UILabel new];
        label.frame=CGRectMake(20, CGRectGetMaxY(self.pickerView.frame)+10, CGRectGetWidth(self.view.frame), 30);
        label.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:label];
        label;
    });
    
    self.stapleLabel = ({
        UILabel *label=[UILabel new];
        label.frame=CGRectMake(20, CGRectGetMaxY(self.fruitLabel.frame)+10, CGRectGetWidth(self.view.frame), 30);
        label.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:label];
        label;
    });
    self.drinkLabel = ({
        UILabel *label=[UILabel new];
        label.frame=CGRectMake(20, CGRectGetMaxY(self.stapleLabel.frame)+10, CGRectGetWidth(self.view.frame), 30);
        label.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:label];
        label;
    });

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foodsArray.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *arrayM=self.foodsArray[component];
    return arrayM.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *arrayM=self.foodsArray[component];
    NSString *name=arrayM[row];
    return  name;
}

-(void)randomFood:(UIButton *)button {
    for (NSInteger component=0; component<self.foodsArray.count; component++) {
        NSUInteger total=[self.foodsArray[component] count];
        NSInteger randomNumber=arc4random()%total;
        NSInteger oldRow=[self.pickerView selectedRowInComponent:component];
        while (oldRow==randomNumber) {
            randomNumber=arc4random()%total;
        }
        [self.pickerView selectRow:randomNumber inComponent:component animated:YES];
        [self pickerView:nil didSelectRow:randomNumber inComponent:component];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *name=self.foodsArray[component][row];
    if (0==component)
    {
        self.fruitLabel.text=name;
    }else if(1==component)
    {
        self.stapleLabel.text=name;
    }else
    {
        self.drinkLabel.text=name;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
