import SwiftUI

struct CircleGraph: View {
    
    @Binding var progress: Progress
    let gradient = Gradient(colors: [.orange, .red])
    
       
   var body: some View {
       Circle()
           .trim(from: 0, to: CGFloat(min(progress.fractionCompleted, 1)))
           .stroke(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom), lineWidth: 20)
           .frame(width: 140, height: 140)
           .rotationEffect(Angle(degrees: -90))
           .animation(.linear(duration: 3), value: progress.fractionCompleted)
   }
}
