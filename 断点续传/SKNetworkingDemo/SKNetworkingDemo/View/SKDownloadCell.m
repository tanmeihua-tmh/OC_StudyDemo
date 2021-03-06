//
//  SKDownloadCell.m
//  SKNetworkingDemo
//
//  Created by wushangkun on 16/5/20.
//  Copyright © 2016年 wushangkun. All rights reserved.
//

#import "SKDownloadCell.h"
#import "SKDownloadModel.h"


@implementation SKDownloadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressView.progress = 0.0;
}

- (IBAction)tapIconImageView:(UITapGestureRecognizer *)sender {
    
    if (self.startDownloadAciton) {
        self.startDownloadAciton(self.model);
    }
    
}

-(void)setModel:(SKDownloadModel *)model{
    _model = model;
    self.titleLabel.text = model.name;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.progressView.progress = model.bytesRead / (CGFloat) model.totalBytesRead;
        // self.currentProgress.text = [NSString stringWithFormat:@"%lld/%lld",model.bytesRead,model.totalBytesRead];
        double byts =  model.bytesRead * 1.0 / 1024 / 1024;
        double total =  model.totalBytesRead * 1.0 / 1024 / 1024;
        self.currentProgress.text = [NSString stringWithFormat:@"%.1lfMB/%.1fMB",byts,total];
        self.networkSpeed.text = model.speed;
    });

    switch (model.status) {
        case kSKDownloadStatusNotLoaded:
            self.statusLabel.text = @"开始缓存";
            break;
        case kSKDownloadStatusIsLoading:
            self.statusLabel.text = @"暂停缓存";
            self.networkSpeed.hidden = NO;
            break;
        case kSKDownloadStatusPausing:
            self.statusLabel.text = @"继续缓存";
            self.networkSpeed.hidden = YES;
            break;
        case kSKDownloadStatusDone:
            self.statusLabel.text = @"已缓存";
            self.networkSpeed.hidden = YES;
            break;
        case kSKDownloadStatusError:
            self.statusLabel.text = @"缓存出错";
            break;
        default:
            break;
    }
}


-(void)updateConstraints {
    [super updateConstraints];
    
    
}


@end
