import SwiftUI

public struct CustomCursorBody: View {
	var color: Color
    public var body: some View {
        Capsule()
            .foregroundColor(color)
            .frame(width: 2, height: 32)
    }
}
