//
//  LVStatusCell.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/9.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusCell.h"
#import "LVStatus.h"
#import "LVStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "LVUser.h"
#import "LVPhoto.h"

@interface LVStatusCell ()
/*原创微博*/

/**原创微博整体*/
@property (nonatomic, weak)  UIView *originalView;
/**头像*/
@property (nonatomic, weak)  UIImageView *iconView;
/**会员图标*/
@property (nonatomic, weak)  UIImageView *vipView;
/**配图*/
@property (nonatomic, weak)  UIImageView *photoView;
/**昵称*/
@property (nonatomic, weak)  UILabel  *nameLabel;
/**时间*/
@property (nonatomic, weak)  UILabel  *timeLabel;
/**来源*/
@property (nonatomic, weak)  UILabel  *sourceLabel;
/**正文*/
@property (nonatomic, weak)  UILabel  *contentLabel;


/*转发微博 */
/**转发微博整体*/
@property (nonatomic, weak)  UIView *retweetView;

/**转发微博 正文 + 昵称*/
@property (nonatomic, weak)  UILabel *retweetContentLabel;

/**转发微博图片*/
@property (nonatomic, weak)  UIImageView *retweetPhotoView;

@end

@implementation LVStatusCell


+ (instancetype)cellWithTabelView:(UITableView *)tabelView
{
    static NSString *ID = @"status";
    
    LVStatusCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell){
        cell = [[LVStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
 
    }
    
    return self;
}


- (void)setupRetweet
{
    /** 转发微博整体*/
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = LVColor(240, 240, 240);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博 正文 + 昵称*/
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = LVStatusCellRetweetContentFont;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图*/
    UIImageView *retweetPhotoView = [[UIImageView alloc]init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView =retweetPhotoView;
}


/**
 *  初始化转发微博
 */
- (void)setupOriginal
{

    /**原创微博整体*/
    UIView *originalView = [[UIView alloc]init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    /**头像*/
    UIImageView *iconView = [[UIImageView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /**会员图标*/
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    /**配图*/
    UIImageView *photoView = [[UIImageView alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    /**昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = LVStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    /**时间*/
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = LVStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    /**来源*/
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = LVStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    /**正文*/
    UILabel *contenLabel = [[UILabel alloc]init];
    contenLabel.font = LVStatusCellContentFont;
    contenLabel.numberOfLines = 0;
    [originalView addSubview:contenLabel];
    self.contentLabel = contenLabel;
}


- (void)setStatusFrame:(LVStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    LVStatus *status = statusFrame.status;
    LVUser *user = status.user;
    
    /**原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    /**头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /**会员图标*/
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    /**配图*/

    if (status.pic_urls.count){
        self.photoView.frame = statusFrame.photoViewF;
        LVPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
    
    
    /**昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    /**时间*/
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame  = statusFrame.timeLabelF;
    
    /**来源*/
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    /**正文*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    
    /**转发的微博 */
    
    if (status.retweeted_status){
        LVStatus *retweeted_status = status.retweeted_status;
        LVUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        
        /**被转发微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发微博正文*/
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /**被转发微博有配图 */
        if (retweeted_status.pic_urls.count){
            
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            LVPhoto *retweetPhoto = [retweeted_status.pic_urls firstObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    
    

}














@end
