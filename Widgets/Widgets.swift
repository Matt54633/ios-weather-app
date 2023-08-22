//
//  Widgets.swift
//  Widgets
//
//  Created by Matt Sullivan on 11/08/2023.
//

import WidgetKit
import SwiftUI
import WeatherKit
import CoreLocation

struct Provider: TimelineProvider {
    @ObservedObject var userLocationHelper = LocationManager.shared
    @State private var userLocation = CLLocation(latitude: 0, longitude: 0)
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), temperature: "23", conditions: "Mostly cloudy", symbol: "cloud", townName: "London")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), temperature: "23", conditions: "Mostly cloudy", symbol: "cloud",  townName: "London")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            if let userLocation = userLocationHelper.userLocation {
                if let townName = userLocationHelper.placemark?.locality {
                    let nextUpdate = Date().addingTimeInterval(900)
                    let weather = try await WeatherService.shared.weather(for: userLocation)
                    let entry = SimpleEntry(date: .now, temperature: weather.currentWeather.temperature.value.rounded(.toNearestOrEven).formatted(), conditions: weather.currentWeather.condition.description, symbol: weather.currentWeather.symbolName, townName: townName)
                    let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                    completion(timeline)
                }
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let temperature: String
    let conditions: String
    let symbol: String
    let townName: String
}

struct WidgetsEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack {
            switch widgetFamily {
            case .systemSmall:
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("\(entry.temperature)°")
                            .font(.system(size: 44))
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: entry.symbol)
                            .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .font(.title2)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(entry.conditions.capitalizedSentence) for the next hour")
                            .padding(.bottom, 1)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    HStack {
                        Text(entry.townName)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "location.fill")
                            .foregroundStyle(.white)
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size: 12))
                    }
                }
            case .systemMedium:
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("\(entry.temperature)°")
                            .font(.system(size: 44))
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: entry.symbol)
                            .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .font(.title)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(entry.conditions.capitalizedSentence) for the next hour")
                            .padding(.bottom, 1)
                    }
                    .font(.system(size: 16))
                    Spacer()
                    HStack {
                        HStack {
                            Text(entry.townName)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "location.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                                .symbolRenderingMode(.monochrome)
                        }
                    }
                }
            default:
                Text("Unsupported")
            }
        }
        .symbolRenderingMode(.multicolor)
        .foregroundStyle(.white)
        .fontDesign(.rounded)
        .containerBackground(for: .widget) {
            LinearGradient(colors: [Color("Dark Purple"), Color("Lilac")], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0.5, y: 0.6))
        }
    }
}

struct Widgets: Widget {
    let kind: String = "Widgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Current Location Weather")
        .description("View the current weather at your location")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

//#Preview(as: .systemSmall) {
//    Widgets()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
