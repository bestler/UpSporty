//
//  MainViewModel.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var test: String = "Connected"
    
    @Published var allSports: [SportModel] = SportModel.allSports
    
    //MARK: AddNewGoal
    @Published var selectedSport: Int16 = 0
    @Published var dueDate: Date = Date()
    @Published var target: String = "0"
    @Published var selectedHourPicker: Int = 0
    @Published var selectedMinutePicker: Int = 0
    @Published var selectedSecondPicker: Int = 0
    @Published var selectedMilliSecondPicker: Int = 0
    
    //MARK: Goals
    @Published var allGoals: [GoalEntity] = []
    
    
    init() {
       getGoals()
    }
    
    func checkSportSelection() -> Bool {
        guard selectedSport != 0 else { return false }
        return true
    }
    
    func saveGoal() {
        addGoal()
        save()
    }
    
    private func addGoal() {
        guard selectedSport != 0 else { return }
        let newGoal = GoalEntity(context: manager.context)
        newGoal.id = UUID()
        newGoal.dueDate = dueDate
        newGoal.isCompleted = false
        newGoal.sportID = selectedSport
        guard let target = Double(target) else { return }
        newGoal.target = target
        newGoal.targetTime = calculateMilliseconds()
    }
    
    private func calculateMilliseconds() -> Int64 {
        return 100
    }
    
    private func getGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        //let filter = NSPredicate(format: "name == %@", "Apple")
        //request.predicate = filter
        
        do {
            allGoals = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    private func save() {
        allGoals.removeAll()
        
        self.manager.save()
        self.getGoals()
     /*   businesses.removeAll()
        deparments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
        */
        
        
    }
}
