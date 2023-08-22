import SwiftUI
import WeatherKit

struct RainInfoGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cloud.rain.fill")
                Text("Rainfall")
            }
            Text((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! > 0 ? "\((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)?.formatted() ?? "") mm" : "")
                .font(.system(size: 44))
                .fontWeight(.semibold)
            Spacer()
            if (hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! <= 0 {
                Gauge(value: ((hourData?.precipitationChance ?? dayData?.precipitationChance) ?? 0) * 100, in: 0.0...100.0) {
                    Text("%")
                        .foregroundStyle(.white)
                } currentValueLabel: {
                    Text("\((Int((hourData?.precipitationChance ?? dayData?.precipitationChance) ?? 0) * 100))")
                        .foregroundStyle(.white)
                }
                .scaleEffect(1.6)
                .frame(maxWidth: .infinity)
                .gaugeStyle(.accessoryCircular)
                .tint(LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .leading, endPoint: .trailing))
                Spacer()
            }
            Text((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! > 0 ? "Amount of rain" : "Chance of rain")
                .font(.system(size: 14))
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}


//#Preview {
//    RainInfoGraph()
//}
