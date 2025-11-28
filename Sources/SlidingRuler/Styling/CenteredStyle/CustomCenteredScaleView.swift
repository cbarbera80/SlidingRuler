//
//  BlankCellView.swift
//  
//  SlidingRuler
//
//  MIT License
//
//  Copyright (c) 2020 Pierre Tacchi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


import SwiftUI

struct CustomCenteredScaleView: ScaleView {
    struct ScaleShape: Shape {
        let tickSpacing: CGFloat
        let tickColor: Color

        fileprivate var unitMarkSize: CGSize { .init(width: 2.0, height: 40.0)}
        fileprivate var halfMarkSize: CGSize { .init(width: 2.0, height: 40)}
        fileprivate var fractionMarkSize: CGSize { .init(width: 2.0, height: 40)}

        func path(in rect: CGRect) -> Path {
            let centerX = rect.center.x
            let centerY = rect.center.y
            var p = Path()

            p.addRoundedRect(in: unitRect(x: centerX, y: centerY), cornerSize: .init(square: unitMarkSize.width/2))

            var x = centerX + tickSpacing
            while x <= rect.maxX {
                p.addRoundedRect(in: fractionRect(x: x, y: centerY), cornerSize: .init(square: fractionMarkSize.width/2))
                x += tickSpacing
            }

            x = centerX - tickSpacing
            while x >= 0 {
                p.addRoundedRect(in: fractionRect(x: x, y: centerY), cornerSize: .init(square: fractionMarkSize.width/2))
                x -= tickSpacing
            }

            return p
        }

        private func unitRect(x: CGFloat, y: CGFloat) -> CGRect { .init(center: .init(x: x, y: y), size: unitMarkSize) }
        private func fractionRect(x: CGFloat, y: CGFloat) -> CGRect { .init(center: .init(x: x, y: y), size: fractionMarkSize) }
    }

    let width: CGFloat
    let height: CGFloat
    let tickSpacing: CGFloat
    let tickColor: Color

    var shape: ScaleShape { .init(tickSpacing: tickSpacing, tickColor: tickColor) }

    var unitMarkWidth: CGFloat { shape.unitMarkSize.width }
    var halfMarkWidth: CGFloat { shape.halfMarkSize.width }
    var fractionMarkWidth: CGFloat { shape.fractionMarkSize.width }

    init(width: CGFloat, height: CGFloat = 32, tickSpacing: CGFloat = 24, tickColor: Color = Color(red: 5/255, green: 8/255, blue: 37/255)) {
        self.width = width
        self.height = height
        self.tickSpacing = tickSpacing
        self.tickColor = tickColor
    }
}

@available(iOS 17.0, *)
#Preview {
	@Previewable @State var value: Double = 100
	
	SlidingRuler(value: $value, in: 50...200, step: 10, snap: .unit)
		.slidingRulerStyle(
			CustomCenteredSlidingRulerStyle(
				tickColor: .red,
				cursorColor: .yellow,
				labelFont: .footnote,
				labelColor: .gray
			)
		)
		.frame(height: 50)
}
