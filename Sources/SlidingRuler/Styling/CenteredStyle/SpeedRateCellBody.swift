import SwiftUI

struct SpeedRateBlankCellBody: NativeRulerCellView {
	var mark: CGFloat
	var bounds: ClosedRange<CGFloat>
	var step: CGFloat
	var cellWidth: CGFloat
	var tickSpacing: CGFloat
	var tickColor: Color

	static var fractions: Int { 5 }

	var scale: some ScaleView { CustomCenteredScaleView(width: cellWidth, tickSpacing: tickSpacing, tickColor: tickColor) }
}

struct SpeedRateCellBody: NativeMarkedRulerCellView {
	var mark: CGFloat
	var bounds: ClosedRange<CGFloat>
	var step: CGFloat
	var cellWidth: CGFloat
	var numberFormatter: NumberFormatter?
	var tickSpacing: CGFloat = 24
	var tickColor: Color = .gray
	var labelFont: Font = .footnote
	var labelColor: Color? = nil

	static var fractions: Int { 5 }

	var cell: some RulerCellView {
		SpeedRateBlankCellBody(
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
