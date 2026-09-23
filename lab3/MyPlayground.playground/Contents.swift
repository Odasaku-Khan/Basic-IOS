import UIKit

// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each signature when you start working on it.


// MARK: Level 1 · Decoding Telemetry

// 1.1
func parseReading(_ raw: String) -> Reading? {
    let parts = raw.split(separator:":", maxSplits: 1)
    guard parts.count==2 else {
        return nil
    }
    let sensor = parts[0].trimmingCharacters(in: .whitespaces)
        let valueString = parts[1].trimmingCharacters(in: .whitespaces)

        guard !sensor.isEmpty,
              let value = Int(valueString) else {
            return nil
        }

        if sensor != "TEMP" && value < 0 {
            return nil
        }
        return Reading(sensor: sensor, value: value)
    }
    
print(parseReading("TEMP:-342"))
print(parseReading("O2:abc"))

// 1.2
func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid:[Reading] = []
    var invalidCount = 0
    for line in lines {
        if let reading = parseReading(line){
            valid.append(reading)
        }else {
            invalidCount += 1
        }
    }
    return (valid , invalidCount)
}
print(parseLog([]))
print(parseLog(["08:89", "O2:23", "TEMP:37", "-75:89",":23"]))

// MARK: Level 2 · Analysis

// 2.1
func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var selected: [Reading] = []
    for selection in readings {
        if isIncluded(selection){
            selected.append(selection)
        }else{}
    }
    return selected
}
func values(of readings: [Reading]) -> [Int] {
    var value:[Int] = []
    for each in readings {
        value.append(each.value)
    }
    return value
}
let A = select(parseLog(rawLog).valid){
    $0.sensor == "O2"
}

// 2.2
func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    if values.isEmpty {
        return nil
    }
    var min = values[0]
    var max = values[0]
    var sum:Double = 0
    var count = Double(values.count)
    for each in values {
        sum += Double(each)
        if each < min {
            min=each
        }
        if each > max {
            max=each
        }
    }
    return (min,max,(sum/count))
    
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}

let B = stats(
    of: values(
        of: select(
            parseLog(rawLog).valid){
                $0.sensor == "O2"
            }
            ))

// 2.3 · The Closure Ladder (5 sorts, then compare results in code)

let sorted_1 = parseLog(rawLog).valid.sorted(by: {
    (first: Reading, second: Reading) -> Bool in
    return first.value > second.value
})
let sorted_2 = parseLog(rawLog).valid.sorted(by: {
    first, second in
    return first.value>second.value
})

let sorted_3 = parseLog(rawLog).valid.sorted(by: {
    first, second in
    first.value > second.value
})
let sorted_4 = parseLog(rawLog).valid.sorted(by: {
    $0.value>$1.value
})

let sorted_5 = parseLog(rawLog).valid.sorted {
    $0.value>$1.value
}
if values(of: sorted_1) == values(of: sorted_2) && values(of: sorted_2) == values(of: sorted_3) && values(of: sorted_3) == values(of: sorted_4) && values(of: sorted_4) == values(of: sorted_5){
    print("Correct")
}

// MARK: Level 3 · Temperature Stabilization

// 3.1
func heatUp(_ t: Int) -> Int {
    return (t+5)
}
func coolDown(_ t: Int) -> Int {
    return (t-3)
}
func hold(_ t: Int) -> Int {
    return t
}
func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 {
        return heatUp
    }else if temp > 24 {
        return coolDown
    }else{
        return hold
    }
}

// 3.2
func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var temp = start
    var steps = 0
    while (18<temp || temp>24) && steps < maxSteps {
        let protocols = chooseProtocol(for: temp)
        temp = protocols(temp)
        steps += 1
    }
    let isStable = (18...24).contains(temp)
    
    return (temp , steps ,isStable)
}
var C: Int = 0
if let StatsO2 = stats(
    of: values(
        of: select(
            parseLog(rawLog).valid){
                $0.sensor == "O2"
        })) {
    C = runUntilStable(from: Int(StatsO2.average)).steps
        }


// MARK: Level 4 · The Crew

// 4.1
func oxygenLevel(of member: CrewMember) -> Int? {
    return member.module?.oxygenTank?.level
}

// 4.2
func status(of member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member)else {
        let location = member.module?.name ?? "no data (open space)"
        return "\(member.name): no data (\(location))"
    }
    if level < 20 {
        return ("\(member.name): \(level)%  CRITICAL")
    }else{
        return ("\(member.name): \(level)%  OK")
    }
}

// 4.3
@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    if amount < 0 {
        return 0
    }
    let freespace = 100 - target
    let transfered = min(amount, min(source, freespace))
    source -= transfered
    target += transfered
    return transfered
}
var D = 0
if var labTank = lab.oxygenTank, var habtank = hab.oxygenTank {
    transferOxygen(from: &labTank.level, to: &habtank.level, amount: 30)
    D = habtank.level
}


// 4.4
func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var saveMemeber: [CrewMember] = []
    var result: [String] = []
    for name in names {
        guard let member = roster[name] else {
            print("unkown crew member \(name)")
            continue
        }
        saveMemeber.append(member)
        for member in saveMemeber {
            result.append(name)
        }
    }
    saveMemeber.sort{ $0.priority<$1.priority}
    return (result)
}


// MARK: Level 5 · The Saboteur's Logbook
// The saboteur's code is below, commented out (it needs your
// oxygenLevel(of:) to compile). Comment on every problem, then
// write fixed versions and a test that proves the logic bug is gone.

func reportOxygen(for member: CrewMember) -> String {
    if let level = oxygenLevel(of: member) {
        return "\(member.name): \(level) %"
    }else {
        return "\(member.name): no data"
    }
}

func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member){
            if level < 20 {
                return member.name
            }
        }
    }
    return nil
}



// MARK: Finale · Launch Code

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")


// MARK: Bonus

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var count = 0
    return { level in
        if level < threshold {
            count += 1
            print ("Alarm \(count)")
            return true
        }
        return false
    }
}


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. guard let vs if let beyond syntax:

 2. Why can't you pass [Int] to stats(_ values: Int...)?

 3. Why doesn't transferOxygen(from: &x, to: &x, amount: 5) compile?

 4. Why doesn't oxygenLevel(of: dana) ?? "no data" compile?

 5. Full type of chooseProtocol and how to read it:

 Bonus. Where does the alarm counter live after makeAlarm returns?

*/
