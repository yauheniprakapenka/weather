//
//  KindOfWeather.swift
//  Weather
//
//  Created by yauheni prakapenka on 30/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class TypeOfWeather {
    
    let sunny = ["Sunny", "Clear"]
    let cloudy = ["Freezing fog", "Partly cloudy", "Cloudy", "Overcast", "Mist", "Blizzard", "Fog"]
    let rainy = ["Patchy rain nearby", "Thundery outbreaks in nearby", "Patchy light drizzle", "Light drizzle", "Light rain", "Moderate rain at times", "Moderate rain", "Heavy rain at times", "Heavy rain", "Light freezing rain", "Light rain shower", "Moderate or heavy rain shower", "Torrential rain shower", "Light sleet showers", "Moderate or heavy sleet showers", "Patchy light rain in area with thunder", "Moderate or heavy rain in area with thunder"]
    let snow = ["Patchy snow nearby", "Patchy sleet nearby", "Patchy freezing drizzle nearby", "Blowing snow", "Freezing drizzle", "Moderate or heavy freezing rain", "Light sleet", "Moderate or heavy sleet", "Patchy light snow", "Light snow", "Patchy moderate snow", "Moderate snow", "Patchy heavy snow", "Heavy snow", "Ice pellets", "Light snow showers", "Moderate or heavy snow showers", "Light showers of ice pellets", "Moderate or heavy showers of ice pellets", "Patchy light snow in area with thunder", "Moderate or heavy snow in area with thunder"]
    
    func fetchTypeOfWeather(kind: String) -> String {
        var gif = ""
        
        if sunny.contains(kind) {
            gif = "Sunny"
        } else if cloudy.contains(kind) {
            gif = "Cloudy"
        } else if rainy.contains(kind) {
            gif = "Rainy"
        } else if snow.contains(kind) {
            gif = "Snow"
        } else {
            gif = ""
        }
        
        return gif
    }

}




