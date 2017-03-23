//
//  CDZPicker.m
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2016/11/18.
//  Copyright © 2016年 Nemocdz. All rights reserved.

#import "CDZPicker.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BACKGROUND_BLACK_COLOR [UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]
static const int pickerViewHeight = 228;
static const int toolBarHeight = 44;

@interface CDZPicker()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSString *selectedString;
@property (nonatomic,  copy) MTCancelBlock cancelBlock;
@property (nonatomic,  copy) MTConfirmBlock confirmBlock;
@end

@implementation CDZPicker

#pragma mark - AboutInit
+ (void)showPickerInView:(UIView *)view
        withObjectsArray:(NSArray *)array
         withCancelBlock:(MTCancelBlock)cancelBlock
        withConfirmBlock:(MTConfirmBlock)confirmBlock {
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.bounds];
    pickerView.dataArray = array;
    //参数block传入到内部，需要内部调用block。
    pickerView.cancelBlock = cancelBlock;
    pickerView.confirmBlock = confirmBlock;
    //未滑动默认为第一个数值
    pickerView.selectedString = array[0];
    [pickerView initView];
    [view addSubview:pickerView];
}


- (void)initView{
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickerViewHeight, SCREEN_WIDTH, pickerViewHeight + toolBarHeight)];
    containerView.backgroundColor = [UIColor cyanColor];
    
    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -70, 5, 40, 30)];
    btnOK.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(pickerViewBtnOk:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnOK];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(30, 5, 40, 30)];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnCancel];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, pickerViewHeight)];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containerView addSubview:pickerView];
    
    self.backgroundColor = BACKGROUND_BLACK_COLOR;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewDismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    [self addSubview:containerView];
}

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class]description]);
}

#pragma mark - event response
- (void)pickerViewDismiss {
    NSLog(@"点击了tap");
    [self removeFromSuperview];
}

//确认
- (void)pickerViewBtnOk:(UIButton *)btn {
    self.confirmBlock(self.selectedString);
    [self removeFromSuperview];
}

//取消
- (void)pickerViewBtnCancel:(UIButton *)btn {
    self.cancelBlock();
    [self removeFromSuperview];
}
#pragma mark - UIPickerViewDataSource
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    return YES;
}

#pragma mark - PickerDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

#pragma mark - PickerDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedString = self.dataArray[row];
    NSLog(@"self.selectedString: ---%@",self.selectedString);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.dataArray[row];
    genderLabel.font = [UIFont systemFontOfSize:23.0];
    genderLabel.textColor = [UIColor blackColor];
    
    return genderLabel;
}


@end

