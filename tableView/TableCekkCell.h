//
//  TableCekkCell.h
//  tableView
//
//  Created by Jake on 2/03/2014.
//  Copyright (c) 2014 Jake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCekkCell : UITableViewCell

//what UI elements are we going to have in the table cells? these are outlets..

@property (strong, nonatomic) IBOutlet UILabel * TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel * DescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel * PriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end
