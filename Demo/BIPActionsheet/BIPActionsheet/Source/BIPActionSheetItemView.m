//
//  BIPActionSheetItemView.m
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "BIPActionSheetItemView.h"
#import "BIPActionSheetItem.h"
#import "BIPActionSheetConstants.h"
#import "BIPActionSheet.h"
#import "UIImage+BIPActionSheet.h"

@interface BIPActionSheetItemView()

@property (nonatomic, strong) UIImageView        *imageView;

@property (nonatomic, strong) UILabel            *itemLabel;
@property (nonatomic, strong) UILabel            *titleLabel;

@property (nonatomic, strong) UIButton           *button;
@property (nonatomic, strong) UIView             *lineView;
@property (nonatomic, strong) BIPActionSheetItem *item;
@property (nonatomic, strong) BIPActionSheet *ownerActionSheet;

@end

@implementation BIPActionSheetItemView

#pragma mark - Initialize

- (instancetype)initWithItem:(BIPActionSheetItem *)item isHeadlineItem:(BOOL)isHeadlineItem ownerSheet:(BIPActionSheet *)ownerSheet
{
    if (self = [super init])
    {
        self.item = item;
        self.ownerActionSheet = ownerSheet;
        
        self.imageView.image = item.image;
        
        if (item.textColor)
        {
            self.itemLabel.textColor = item.textColor;
        }
        
        [self addSubview:self.imageView];
        
        if (!isHeadlineItem) // no need to add button because title of actionsheet will not have any action handler
        {
            [self addSubview:self.button];
            [self addSubview:self.itemLabel];
            self.itemLabel.text = item.title;
        }
        else
        {
            [self addSubview:self.titleLabel];
            self.titleLabel.text = item.title;
        }

        [self addSubview:self.lineView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Lazy Initializers

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundImage:[UIImage bip_imageWithColor:[UIColor colorWithWhite:0 alpha:0.1]] forState:UIControlStateHighlighted];
        [_button setBackgroundImage:[UIImage bip_imageWithColor:[UIColor colorWithWhite:0 alpha:0.1]] forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (UILabel *)itemLabel
{
    if (!_itemLabel)
    {
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemLabel.textColor        = [UIColor darkGrayColor];
        _itemLabel.backgroundColor  = [UIColor clearColor];
        _itemLabel.font             = [UIFont systemFontOfSize:18];
    }
    
    return _itemLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor  = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.numberOfLines = 0.f;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.minimumScaleFactor = 0.5;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        _lineView.alpha = 0.2f;
    }
    
    return _lineView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _imageView;
}

#pragma mark - Button Action

- (void)buttonTapped:(UIButton *)sender
{
    sender.selected = YES;
    
    [_ownerActionSheet dismiss];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBIPActionSheetHideAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_item.actionHandler)
        {
            _item.actionHandler(_ownerActionSheet);
        }
    });
}

#pragma mark - Appearence Setters

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
}

- (void)setItemFont:(UIFont *)itemFont
{
    _itemFont = itemFont;
    _itemLabel.font = itemFont;
}

- (void)setItemTextColor:(UIColor *)itemTextColor
{
    _itemTextColor = itemTextColor;
    _itemLabel.textColor = self.item.textColor ?: itemTextColor;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    _titleTextColor = titleTextColor;
    _titleLabel.textColor = titleTextColor;
}

- (void)setCancelButtonFont:(UIFont *)cancelButtonFont
{
    _cancelButtonFont = cancelButtonFont;
    [_ownerActionSheet.cancelButton.titleLabel setFont:cancelButtonFont];
}

- (void)setCancelButtonColor:(UIColor *)cancelButtonColor
{
    _cancelButtonColor = cancelButtonColor;
    [_ownerActionSheet.cancelButton setTitleColor:cancelButtonColor forState:UIControlStateNormal];
}

- (void)setImageAlignment:(BIPActionSheetImageAllignment)imageAlignment
{
    _imageAlignment = imageAlignment;
    
    if (imageAlignment == Right) // defaults left
    {
        [self setNeedsLayout];
    }
}

- (void)setImageWidth:(CGFloat)imageWidth
{
    _imageWidth = imageWidth;
    [self setNeedsLayout];
}

- (void)setImageHeight:(CGFloat)imageHeight
{
    _imageHeight = imageHeight;
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 24.f;
    CGFloat lineViewHeight = 1.f;
    CGFloat imageHeight = self.imageHeight ?: 23.5;
    CGFloat imageWidth = self.imageWidth ?: 23.5;

    // imageView Frame
    CGRect imageViewRect        = CGRectZero;
    imageViewRect.origin.x      = self.imageAlignment == Left ? padding : self.frame.size.width - padding - imageWidth;
    imageViewRect.size.width    = imageWidth;
    imageViewRect.size.height   = imageHeight;
    imageViewRect.origin.y      = (self.frame.size.height - imageViewRect.size.height) / 2;
    _imageView.frame            = imageViewRect;
    
    // textlabel Frame
    CGRect textLabelRect        = CGRectZero;
    textLabelRect.origin.x      = self.imageAlignment == Left ? imageViewRect.origin.x + imageViewRect.size.width + padding : padding;
    
    if (_item.image == nil)
    {
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        textLabelRect.origin.x   = padding;
    }
    
    textLabelRect.size.width    = self.frame.size.width - (textLabelRect.origin.x + padding);
    textLabelRect.origin.y      = lineViewHeight;
    textLabelRect.size.height   = self.frame.size.height - 2 * lineViewHeight;
    _itemLabel.frame            = textLabelRect;
    
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    // imageView Frame
    CGRect lineViewRect        = CGRectZero;
    lineViewRect.origin.x      = 0;
    lineViewRect.origin.y      = self.frame.size.height - lineViewHeight;
    lineViewRect.size.width    = self.frame.size.width;
    lineViewRect.size.height   = lineViewHeight;
    _lineView.frame            = lineViewRect;
    
    // button Frame
    _button.frame = self.bounds;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    BIPActionSheetItemView *copyItemView = [[self class] allocWithZone:zone];
    
    if (copyItemView)
    {
        copyItemView.imageView        = self.imageView;
        copyItemView.itemLabel        = self.itemLabel;
        copyItemView.button           = self.button;
        copyItemView.lineView         = self.lineView;
        copyItemView.item             = [self.item copyWithZone:zone];
        copyItemView.ownerActionSheet = [self.ownerActionSheet copyWithZone:zone];
        copyItemView.imageAlignment   = self.imageAlignment;
        copyItemView.titleLabel       = self.titleLabel;
        copyItemView.imageWidth       = self.imageWidth;
        copyItemView.imageHeight      = self.imageHeight;
    }
    
    return copyItemView;
}

@end
