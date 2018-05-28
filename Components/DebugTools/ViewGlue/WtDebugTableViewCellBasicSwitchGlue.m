//
// Created by wtfan on 2017/5/19.
//

#import "WtDebugTableViewCellBasicSwitchGlue.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "WtCore.h"
#import "WtDebugTableViewCellBasicSwitch.h"
#import "UISwitch+RACSignalSupport.h"
#import "UITableViewCell+RACSignalSupport.h"

@interface WtDebugTableViewCellBasicSwitchGlue ()
@end

@implementation WtDebugTableViewCellBasicSwitchGlue

- (instancetype)init {
    if (self = [super init]) {
        [self createControl];
    }
    return self;
}

- (void)createControl {
    @weakify(self);
    [self.tableViewDataSource selector:@selector(tableView:cellForRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
        @strongify(self);
        NSString *cellIdentifier = @"WtDebugTableViewCellBasicSwitchIdentifier";
        WtDebugTableViewCellBasicSwitch *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[WtDebugTableViewCellBasicSwitch alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = self.name;
        cell.subTitleLabel.text = self.detailDescription;
        cell.switchControl.on = self.switchOn;
        
        @weakify(self);
        [[[cell.switchControl rac_newOnChannel] takeUntil:[cell rac_prepareForReuseSignal]] subscribeNext:^(id x) {
            @strongify(self);
            self.switchOn = [x boolValue];
        }];
        
        @weakify(cell);
        [[RACObserve(self, switchOn) takeUntil:[cell rac_prepareForReuseSignal]] subscribeNext:^(id x) {
            @strongify(cell);
            cell.switchControl.on = [x boolValue];
        }];
        
        return cell;
    }];
    
    [self.tableViewDelegate selector:@selector(tableView:heightForRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
        @strongify(self);
        if (self.detailDescription.length > 0) {
            return 60.0;
        }
        return 44.0;
    }];
}

@end
