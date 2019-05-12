//
//  YYCollectionViewCell.h
//  自定义collectionView
//
//  Created by 杨金发 on 16/9/5.
//  Copyright © 2016年 杨金发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemDetail;
@property (strong, nonatomic) IBOutlet UILabel *nowPrice;
@property (strong, nonatomic) IBOutlet UILabel *oldPrice;
@property (strong, nonatomic) IBOutlet UILabel *saleNumber;

@end
