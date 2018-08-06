//
//  EJEduTableViewCell.h
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJEduTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *eduLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;

@end

NS_ASSUME_NONNULL_END
