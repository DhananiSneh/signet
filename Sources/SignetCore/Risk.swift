public struct CallFacts: Equatable {
    public var caller: String
    public var spoofed: Bool
    public var asksForPasscode: Bool
    public var knownContact: Bool

    public init(caller: String, spoofed: Bool, asksForPasscode: Bool, knownContact: Bool) {
        self.caller = caller
        self.spoofed = spoofed
        self.asksForPasscode = asksForPasscode
        self.knownContact = knownContact
    }
}

public enum Risk: String, Equatable {
    case low
    case watch
    case high
}

public enum Signet {
    public static func assess(_ call: CallFacts) -> Risk {
        if call.spoofed || call.asksForPasscode {
            return .high
        }
        if call.knownContact {
            return .low
        }
        return .watch
    }

    public static func headline(for risk: Risk) -> String {
        switch risk {
        case .high:
            return "Incoming · High risk"
        case .watch:
            return "Incoming · Check this call"
        case .low:
            return "Incoming"
        }
    }

    public static func guidance(for call: CallFacts) -> String {
        if call.asksForPasscode {
            return "A real bank does not call to ask for a passcode."
        }
        if call.spoofed {
            return "The number does not match the name on the call."
        }
        if call.knownContact {
            return "This number is already in your contacts."
        }
        return "Signet does not know this caller yet."
    }
}
