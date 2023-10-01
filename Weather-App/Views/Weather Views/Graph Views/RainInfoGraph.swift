import SwiftUI
import WeatherKit

struct RainInfoGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
            HStack {
                Image(systemName: "cloud.rain.fill")
                if (hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! <= 0 {
                    Text("Chance of Rain %")
                } else {
                    Text("Rainfall")
                }
            Spacer()
            Text((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! > 0 ? "\((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)?.formatted() ?? "") mm" : "")
                .font(.title)
                .fontWeight(.semibold)
            if (hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! <= 0 {
                Gauge(value: ((hourData?.precipitationChance ?? dayData?.precipitationChance) ?? 0) * 100, in: 0.0...100.0) {
                    Image(systemName: "gauge.medium")
                        .font(.title)
                } currentValueLabel: {
                    Text("\((Int((hourData?.precipitationChance ?? dayData?.precipitationChance ?? 0) * 100)))")
                }
                .gaugeStyle(RainGaugeStyle())
            }
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}

//#Preview {
//    RainInfoGraph()
//}
