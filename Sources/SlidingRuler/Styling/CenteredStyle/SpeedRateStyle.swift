import SwiftUI

public struct SpeedRateSlidingRulerStyle: SlidingRulerStyle {
	public var cursorAlignment: VerticalAlignment = .top
	public var tickSpacing: CGFloat
	public var tickColor: Color
	public var cursorColor: Color
	public var labelFont: Font
	public var labelColor: Color?

	public init(tickSpacing: CGFloat = 24, tickColor: Color, cursorColor: Color, labelFont: Font = .footnote, labelColor: Color? = nil) {
		self.tickSpacing = tickSpacing
		self.tickColor = tickColor
		self.cursorColor = cursorColor
		self.labelFont = labelFont
		self.labelColor = labelColor
	}

	public func makeCellBody(configuration: SlidingRulerStyleConfiguation) -> some FractionableView {
		SpeedRateCellBody(mark: configuration.mark,
						bounds: configuration.bounds,
						step: configuration.step,
						cellWidth: self.cellWidth,
						numberFormatter: configuration.formatter,
						tickSpacing: tickSpacing,
						tickColor: tickColor,
						labelFont: labelFont,
						labelColor: labelColor)
	}

	public func makeCursorBody() -> some View {
		CustomCursorBody(color: cursorColor)
	}
}
