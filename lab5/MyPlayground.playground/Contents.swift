// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
//  iOS Mobile Development · Module 5 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part3_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section. LegacyBeacon in
//     particular must be reached with an extension, not edited.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • The Health Rule must exist in exactly ONE place in this file.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Drone records recovered from the fleet registry.
/// One `kind` does not correspond to any drone type you will build.
let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

/// Hull sensors. These are NOT drones — they never move and never work a shift.
let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

/// Hardware from the original station. You may not add anything to this
/// declaration — no methods, no protocols, no properties.
struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Power Cell

// Why a class and not a struct here?  ->
//struct → independent value
//class  → shared object with identity/state
final class PowerCell {
    private var charge: Int
    init(charge: Int) {
        self.charge = min(max(charge, 0), 100)
    }
    func level() -> Int {
        return charge
    }
    func spend (_ amount:Int) -> Bool {
        guard (charge >= amount) && amount>0  else{
            return false
        }
        charge = charge - amount
        return true
    }
    func recharge (by amount: Int) {
        if charge > 100 {
            charge=100
        }
        if amount>0 {
            charge=min(charge+amount, 100)
        }
    }
}

// Encapsulation proof (leave this commented, with the compiler error):
//let cell = PowerCell(charge: 50)
//cell.charge = 100
// error:/Users/ablaikhannussipakhyn/Basic IOS/lab5/MyPlayground.playground:89:6 'charge' is inaccessible due to 'private' protection level



// MARK: Level 2 · The Fleet

// 2.1  What does `final` on runOnce() buy you?  ->
class Drone {
    let id: String
    let cell: PowerCell
    
    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }
    var powerCost: Int { 10 }
    var statusLine: String {"\(id): \(cell.level())%"}
    func performTask() -> Int {0}
    final func runOnce() -> Int {
        guard cell.spend(powerCost) else {
            return 0
        }
        return performTask()
    }
}

// 2.2
final class WelderDrone: Drone {
    override var powerCost: Int {
        get {
            return 25
        }
    }
    override func performTask() -> Int {
            return 40
    }
    func weldSeam() -> String{
        "Welded goof Drone is good for master"
    }
}
class ScannerDrone: Drone {
    override var powerCost: Int {
        get {
            return 10
        }
    }
    override func performTask() -> Int {
        return 15
    }
    override var statusLine: String {
        super.statusLine + " [scanner]"
    }
}
final class CargoDrone: Drone {
    override var powerCost: Int {
        return 20
    }
    override func performTask() -> Int {
        return 25
    }
}

// 2.3
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    if kind == "welder" {
        let cell = PowerCell (charge: charge)
        return WelderDrone(id:id,cell: cell)
    }
    if kind == "scanner" {
        let cell = PowerCell (charge: charge)
        return ScannerDrone(id: id, cell: cell)
    }
    if kind == "cargo" {
        let cell = PowerCell(charge: charge)
        return CargoDrone(id: id, cell: cell)
    }else{
        return nil
    }
}

var fleet: [Drone] = []
for record in fleetData {
    guard let drone = makeDrone(kind: record.kind, id: record.id, charge: record.charge) else {
        ("No such drone")
        continue
    }
    fleet.append(drone)
}

// MARK: Level 3 · The Shift
func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    let drones: [Drone] = fleet //not necessary but i like this way
    var count: Int = 0
    var round = rounds
    var totalWork: Int = 0
    while round>0 {
        for drone in drones {
            let x = drone.runOnce()
            totalWork = totalWork + x
        }
        round = round - 1
    }
    for drone in drones {
        print (drone.statusLine)
        if drone.cell.level() >= drone.powerCost {
            count += 1
        }
    }
    print ("Drones with enough charges for one more round: \(count)")
    return totalWork
}
var results_A = runShift(fleet, rounds: 3)
let A = results_A
var result_B = 0
for drone in fleet {
    result_B = result_B + drone.cell.level()
}
let B = result_B
var result_C = 0
for drone in fleet {
    if drone.cell.level() >= drone.powerCost{
        result_C += 1
    }
}
let C = result_C


// MARK: Level 4 · Diagnostics

// 4.1
protocol Diagnosable {
    var componentID: String {get}
    var statusCode: Int {get}
    func diagnose() -> String
}
extension Diagnosable {
    func healthCode(for level:Int) -> Int{
        if level < 20 {
            return 2
        } else if level < 50 {
            return 1
        } else {
            return 0
        }
    }
}
// 4.2
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}

// Why does Drone implement recharge(by:) without `mutating`?  ->
struct SensorModule: Diagnosable, Rechargeable {
    var chargeLevel: Int
    var componentID: String
    var statusCode: Int {
        healthCode(for: chargeLevel)
    }
    func diagnose() -> String {
        return "\(componentID):\(chargeLevel)%"
    }
    mutating func recharge(by amount: Int) {
        if chargeLevel + amount >= 100 && amount > 0 {
            chargeLevel=100
        }
        if chargeLevel + amount < 100 && amount > 0 {
            chargeLevel=chargeLevel+amount
        }
    }
}
//5.1
extension Drone: Diagnosable, Rechargeable {
    var componentID: String {
        return id
    }
    var statusCode: Int {
        healthCode(for: cell.level())
    }
    func diagnose() -> String {
        return "\(id):\(cell.level())%"
    }
    func recharge (by amount: Int) {
        cell.recharge(by: amount)
    }
}

// 4.3
// Why could [Drone] never have held the sensors?  ->
var array: [Diagnosable] = []
for record in sensorData {
    let x = SensorModule(chargeLevel: record.charge, componentID: record.id)
    array.append(x)
}
for dron in fleet {
    array.append(dron)
}

func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var result: String = ""
    for component in components {
        let x = component.diagnose()
        result += x + "\n"
    }
    return result
}
diagnosticsReport(array)


// MARK: Level 5 · Shared Behaviour
// 5.2 · the beacon you cannot edit
extension LegacyBeacon: Diagnosable {
    var componentID: String {
        return name
    }
    var statusCode: Int {
        healthCode(for: signalStrength)
    }
    func diagnose() -> String {
        return "Beacon \(componentID); code \(statusCode); signal \(signalStrength)"
    }
}
array.append(beacon)
diagnosticsReport(array)
var sum: Int = 0
for element in array {
    sum = sum + element.statusCode
}
let D = sum

// 5.3
extension Int {
    var powerBar: String {
        var result: String = ""
        var x = self/10
        if x < 0 {
            x = 0
        }else if x > 10 {
            x = 10
        }
        result = result + String(repeating: "#", count: x) + String(repeating: ".", count: 10-x)
        return result
    }
}
var someInt = 78.powerBar


// MARK: Level 6 · Incident Reports
// Two of these do not compile. Two compile and lie.
// For each: expectation, actual behaviour, the language rule, the fix.


// Report 1
 class PatchDrone: Drone {
     override func performTask() -> Int {
         return 30
     }
 }

// Report 2
let heavyWelderReplacement = WelderDrone(
    id: "HW-1",
    cell: PowerCell(charge: 100)
)

print(heavyWelderReplacement.runOnce())


// Report 3
let incidentFleet: [Drone] = [
    WelderDrone(
        id: "W-9",
        cell: PowerCell(charge: 100)
    )
]

let first = incidentFleet[0]

if let welder = first as? WelderDrone {
    print(welder.weldSeam())
}
// Report 4
protocol FixedLabelled {
    var componentID: String { get }
    func label() -> String
}

extension FixedLabelled {
    func label() -> String {
        return "generic component"
    }
}

struct FixedThruster: FixedLabelled {
    let componentID: String

    func label() -> String {
        return "thruster \(componentID)"
    }
}

let fixedParts: [FixedLabelled] = [
    FixedThruster(componentID: "T-1")
]

print(fixedParts[0].label())


// MARK: Finale · Mission Code

let missionCode = "\(A)-\(B)-\(C)-\(D)"
print("MISSION CODE: \(missionCode)")


// MARK: Bonus

class RuntimeAbstractDrone {
    let id: String
    let cell: PowerCell

    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }

    var powerCost: Int {
        return 10
    }

    func performTask() -> Int {
        fatalError("RuntimeAbstractDrone must not be used directly")
    }

    final func runOnce() -> Int {
        guard cell.spend(powerCost) else {
            return 0
        }

        return performTask()
    }
}

final class RuntimeWelderDrone: RuntimeAbstractDrone {
    override var powerCost: Int {
        return 25
    }

    override func performTask() -> Int {
        return 40
    }
}

// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why does a class satisfy a `mutating` protocol requirement without the
    keyword, while a struct must write it?

 2. One thing inheritance does that protocols cannot, and one thing
    protocols do that inheritance cannot:

 3. What does `final` prevent, and what did it protect in runOnce()?

 4. In Report 4, why did the protocol extension's method win?

*/
