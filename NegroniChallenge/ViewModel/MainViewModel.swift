//
//  MainViewModel.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import Foundation
import CoreData

enum TrainingType: String, CaseIterable {
    case exercise = "Exercise"
    case assestment = "Assestment"
}

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
    
    //MARK: Training sheet
    @Published var currentTrainingSheet: [TrainingEntity] = []
    @Published var newTrainingStep: [TrainingEntity] = []
    @Published var trainingType: TrainingType = .exercise
    @Published var trainingDueDate: Date = Date()
    @Published var exerciseRepetition: Int = 1
    @Published var exerciseTarget: Int = 0
    
    //MARK: Today section
    @Published var todayTrainingSheet: [TrainingEntity] = []
    @Published var todayGoals: [GoalEntity] = []
    
    init() {
        getGoals()
        getTodayGoals()
    }
    
    func checkSportSelection() -> Bool {
        guard selectedSport != 0 else { return false }
        return true
    }
    
    func saveGoal() {
        addGoal()
        saveGoal()
        cleanNewGoalSetup()
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
    //TODO: complete
    private func calculateMilliseconds() -> Int64 {
        return 100
    }
    
    //TODO: complete
    private func cleanNewGoalSetup() {
        
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
    
    func saveTraining(selectedGoal: GoalEntity) {
        for step in newTrainingStep {
            selectedGoal.addToTrainings(step)
        }
        //TODO: update current training sheet
        saveTraining(goal: selectedGoal)
        
    }
    
    private func saveNewTrainingStep() {
        let newTraining = TrainingEntity(context: manager.context)
        newTraining.id = UUID()
        if trainingType == .exercise {
            newTraining.isExcercise = true
            newTraining.repeatCountTotal = Int16(exerciseRepetition)
            newTraining.target = Int16(exerciseTarget)
        }
        newTraining.dueDate = trainingDueDate
        newTraining.repeatCountActual = 0
        newTrainingStep.append(newTraining)
    }
    
    //TODO: complete
    private func cleanNewTrainingSetup() {
        
    }
    
    func getTrainingSheet(for goal: GoalEntity) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        let filter = NSPredicate(format: "goal == %@", goal)
        request.predicate = filter
        do {
            currentTrainingSheet = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    private func saveGaol() {
        allGoals.removeAll()
        todayGoals.removeAll()
        todayTrainingSheet.removeAll()
        
        self.manager.save()
        self.getGoals()
        self.getTodayGoals()
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
    
    private func getTodayGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
         request.sortDescriptors = [sort]
        
        let dateFrom = Calendar.current.startOfDay(for: Date())
        if let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom) {
            let fromFilter = NSPredicate(format: "ANY trainings.dueDate >= %@", dateFrom as CVarArg)
            let toFilter = NSPredicate(format: "ANY trainings.dueDate < %@", dateTo as CVarArg)
            let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [fromFilter, toFilter])
            request.predicate = filter
            
            do {
                todayGoals = try manager.context.fetch(request)
                getTodayTrainingFromTodayGoal(for: todayGoals.first)
            } catch let error {
                print("Error fetching coredata: \(error.localizedDescription)")
            }
        }
    }
    
    private func getTodayTrainingFromTodayGoal(for todayGoal: GoalEntity?) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        if let goal = todayGoal {
            let filter = NSPredicate(format: "goal == %@", goal)
            request.predicate = filter
            do {
                todayTrainingSheet = try manager.context.fetch(request)
            } catch let error {
                print("Error fetching coredata: \(error.localizedDescription)")
            }
        }
    }
 
    private func saveTraining(goal: GoalEntity) {
        currentTrainingSheet.removeAll()
        newTrainingStep.removeAll()
        self.manager.save()
        self.getTrainingSheet(for: goal)
    }
}
