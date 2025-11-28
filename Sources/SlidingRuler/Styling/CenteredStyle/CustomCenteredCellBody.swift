//
//  CenteredCellBody.swift
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

struct CustomBlankCenteredCellBody: NativeRulerCellView {
    var mark: CGFloat
    var bounds: ClosedRange<CGFloat>
    var step: CGFloat
    var cellWidth: CGFloat
    var tickSpacing: CGFloat
    var tickColor: Color

    var scale: some ScaleView { CustomCenteredScaleView(width: cellWidth, tickSpacing: tickSpacing, tickColor: tickColor) }
}

struct CustomCenteredCellBody: NativeMarkedRulerCellView {
    var mark: CGFloat
    var bounds: ClosedRange<CGFloat>
    var step: CGFloat
    var cellWidth: CGFloat
    var numberFormatter: NumberFormatter?
    var tickSpacing: CGFloat = 24
	var tickColor: Color = .gray
	var labelFont: Font = .footnote
	var labelColor: Color? = nil

	var cell: some RulerCellView {
		CustomBlankCenteredCellBody(
			mark: mark,
			bounds: bounds,
			step: step,
			cellWidth: cellWidth,
			tickSpacing: tickSpacing,
			tickColor: tickColor
		)
	}

	var markColor: Color {
		labelColor ?? (bounds.contains(mark) ? .init(.label) : .init(.tertiaryLabel))
	}

	var displayMark: String { numberFormatter?.string(for: mark) ?? "\(mark.approximated())" }

	var body: some View {
		VStack(spacing: 2) {
			cell.equatable()
				.clipShape(cell.maskShape)
			Spacer()
			Text(verbatim: displayMark)
				.font(labelFont.monospacedDigit())
				.foregroundColor(markColor)
				.lineLimit(1)
				.truncationMode(.middle)
				.padding(.horizontal, 2)
				.opacity(bounds.contains(mark) ? 1 : 0)
		}
	}
}
