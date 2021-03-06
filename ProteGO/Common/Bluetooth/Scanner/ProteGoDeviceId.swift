import Foundation
import CoreBluetooth

/// Due to the iOS limitations, we can't advertsie our own manufacturer data as a peripheral.
/// On Android devices it is posssible and very useful to be able to identify devices, which
/// change their MAC addresses every established connection.
///
/// This enum provides unique device identifier covering both cases.
enum ProteGoDeviceId {
    case PeripheralInstance(CBPeripheral)
    case IncompleteBeaconId(Data)
    case BeaconId(BeaconId)

    func hasBeaconId() -> Bool {
        switch self {
        case .PeripheralInstance:
            return false
        case .IncompleteBeaconId:
            return true
        case .BeaconId:
            return true
        }
    }
}

extension ProteGoDeviceId: Hashable, Equatable, CustomStringConvertible {
    var description: String {
        switch self {
        case let .PeripheralInstance(peripheral):
            return peripheral.identifier.uuidString
        case let .IncompleteBeaconId(data):
            return data.toHexString()
        case let .BeaconId(beaconId):
            return beaconId.getData().toHexString()
        }
    }

    static func == (lhs: ProteGoDeviceId, rhs: ProteGoDeviceId) -> Bool {
        switch (lhs, rhs) {
        case let (.PeripheralInstance(lhp), .PeripheralInstance(rhp)):
            return lhp == rhp
        case let (.IncompleteBeaconId(lhd), .IncompleteBeaconId(rhd)):
            return lhd.elementsEqual(rhd)
        case let (.BeaconId(lhb), .BeaconId(rhb)):
            return lhb == rhb
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case let .PeripheralInstance(peripheral):
            hasher.combine(peripheral)
        case let .IncompleteBeaconId(data):
            hasher.combine(data)
        case let .BeaconId(beaconId):
            hasher.combine(beaconId)
        }
    }
}
