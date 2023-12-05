import SwiftUI

// To create a custom modifier, create a new struct that conforms to the ViewModifier protocol
// This has one requirement, which is a method called body that accepts whatever content it's being given to work with, and must return some View
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

// When working with custom modifiers, it's a smart idea to create extensions on View that make them easier to use
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// It's possible to create custom containers as well
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
//  let content: (Int, Int) -> Content
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                    .padding(1)
                }
            }
            .padding(1)
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .titleStyle()
//          .modifier(Title())
//          .font(.largeTitle)
//          .padding()
//          .foregroundStyle(.white)
//          .background(.blue)
//          .clipShape(.capsule)
    }
}

struct ContentView: View {
    var body: some View {
//      VStack(spacing: 10) {
//          CapsuleText(text: "First")
//          CapsuleText(text: "Second")
//
//      }
//
//      Color.blue
//          .frame(width: 300, height: 200)
//          .watermarked(with: "Hacking with Swift")
        
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
//          Text("R\(row) C\(col)")
        }
    }
}

#Preview {
    ContentView()
}
