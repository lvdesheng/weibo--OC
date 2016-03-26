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
#import "LVStatusToolBar.h"
#import "LVStatusPhotosView.h"



@interface LVStatusCell ()
/*原创微博*/

/**原创微博整体*/
@property (nonatomic, weak)  UIView *originalView;
/**头像*/
@property (nonatomic, weak)  UIImageView *iconView;
/**会员图标*/
@property (nonatomic, weak)  UIImageView *vipView;
/**配图*/
@property (nonatomic, weak)  LVStatusPhotosView *photosView;
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
@property (nonatomic, weak)  LVStatusPhotosView *retweetPhotosView;

/** 工具条*/
@property (nonatomic, strong) LVStatusToolBar *toolBar;

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
        
        self.backgroundColor  = [UIColor clearColor];
        //点击时不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        //初始化工具条
        [self setupToolBar];
 
    }
    
    return self;
}


- (void)setupToolBar
{
    LVStatusToolBar *ToolBar = [[LVStatusToolBar alloc]init];
    [self.contentView addSubview:ToolBar];
    self.toolBar = ToolBar;
}

/**
 *  转发微博
 */
- (void)setupRetweet
{
    /** 转发微博整体*/
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = LVColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博 正文 + 昵称*/
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = LVStatusCellRetweetContentFont;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图*/
    LVStatusPhotosView *retweetsPhotoView = [[LVStatusPhotosView alloc]init];
    [self.retweetView addSubview:retweetsPhotoView];
    self.retweetPhotosView =retweetsPhotoView;
}


/**
 *  初始化转发微博
 */
- (void)setupOriginal
{

    /**原创微博整体*/
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
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
    LVStatusPhotosView *photosView = [[LVStatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /**昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = LVStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    /**时间*/
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = LVStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
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
        self.photosView.frame = statusFrame.photoViewF;
        
        self.photosView.photos = status.pic_urls;
        
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    
    /**昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    /**时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + LVStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:LVStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY}, timeSize};
    self.timeLabel.text = time;
    /**来源*/
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + LVStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:LVStatusCellSourceFont];
    self.sourceLabel.frame =(CGRect) {{sourceX,sourceY},sourceSize} ;
    self.sourceLabel.text = status.source;

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
            
            self.retweetPhotosView.frame = statusFrame.retweetPhotoViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
 
    
    /** 工具条*/
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
    
}














@end
