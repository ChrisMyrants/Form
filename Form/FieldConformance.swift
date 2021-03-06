import Functional

public struct FieldConformance {
	public let isValid: Bool
	public let invalidMessages: [String]

	public static var valid: FieldConformance {
		return FieldConformance(isValid: true, invalidMessages: [])
	}

	public static func invalid(message: String) -> FieldConformance {
		return FieldConformance(isValid: false, invalidMessages: [message])
	}
}

extension FieldConformance: Equatable {}

public func == (lhs: FieldConformance, rhs: FieldConformance) -> Bool {
	return lhs.isValid == rhs.isValid
		&& lhs.invalidMessages.isEqual(to: rhs.invalidMessages)
}

extension FieldConformance: Monoid {
	public static var zero: FieldConformance {
		return FieldConformance(isValid: true, invalidMessages: [])
	}

	public func join(_ other: FieldConformance) -> FieldConformance {
		return FieldConformance(
			isValid: isValid && other.isValid,
			invalidMessages: invalidMessages.join(other.invalidMessages))
	}
}
