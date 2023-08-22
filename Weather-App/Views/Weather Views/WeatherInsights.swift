//
//  WeatherInsights.swift
//  Weather-App
//
//  Created by Matt Sullivan on 15/08/2023.
//

import SwiftUI
import WeatherKit

struct TemperatureInsights {
    let maxTemperature: Double
    let minTemperature: Double
}

struct InsightView: View {
    let title: String
    let value: String
    let unit: String?
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 55, height: 55)
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundColor(Color(.transparent))
                VStack {
                    Text(value)
                        .font(.title2)
                        .bold()
                    if let unitValue = unit {
                        Text(unitValue)
                            .font(.caption)
                            .padding(.top, -15)
                    }
                }
            }
            Spacer()
            Text(title)
                .font(.system(size: 13))
        }
    }
}

struct WeatherInsights: View {
    @ObservedObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "wand.and.stars")
                Text("This week's insights")
            }
            Divider()
                .overlay(.white)
            Spacer(minLength: 20)
            HStack {
                if let temperatureInsights = weekTempInsights {
                    InsightView(title: "Max Temp", value: "\(temperatureInsights.maxTemperature.formatted())°", unit: nil)
                    Spacer(minLength: 10)
                    InsightView(title: "Min Temp", value: "\(temperatureInsights.minTemperature.formatted())°", unit: nil)
                }
                Spacer(minLength: 10)
                if let maxUV = maxUVForWeek {
                    InsightView(title: "Max UV", value: maxUV.formatted(), unit: nil)
                }
                Spacer(minLength: 10)
                if let maxWind = maxWindForWeek {
                    InsightView(title: "Max Wind", value: maxWind.formatted(), unit: "mph")
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    var weekTempInsights: TemperatureInsights? {
        var hightTempArray: [Double] = []
        var lowTempArray: [Double] = []
        
        if let dailyForecast = weatherDataHelper.dailyForecast {
            for day in dailyForecast {
                hightTempArray.append(day.highTemperature.value.rounded(.toNearestOrEven))
                lowTempArray.append(day.lowTemperature.value.rounded(.toNearestOrEven))
            }
            
            let maxTemp = hightTempArray.max() ?? 0.0
            let minTemp = lowTempArray.min() ?? 0.0
            
            return TemperatureInsights(maxTemperature: maxTemp, minTemperature: minTemp)
        }
        
        return nil
    }
    
    var maxUVForWeek: Int? {
        var uvArray: [Int] = []
        if let dailyForecast = weatherDataHelper.dailyForecast {
            for day in dailyForecast {
                uvArray.append(day.uvIndex.value)
            }
            return uvArray.max()
        }
        return nil
    }
    
    var maxWindForWeek: Double? {
        var windArray: [Double] = []
        if let dailyForecast = weatherDataHelper.dailyForecast {
            for day in dailyForecast {
                windArray.append(day.wind.speed.value.rounded(.toNearestOrEven))
            }
            return windArray.max()
        }
        return nil
    }
}

#Preview {
    WeatherInsights()
}
