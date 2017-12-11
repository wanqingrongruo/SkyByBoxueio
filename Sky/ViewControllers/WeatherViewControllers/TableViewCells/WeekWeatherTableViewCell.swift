//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by roni on 2017/12/11.
//  Copyright © 2017年 Mars. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humid: UILabel!
    
    var model: ForecastData?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
