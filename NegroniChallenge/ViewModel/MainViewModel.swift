//
//  MainViewModel.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import CoreData
import Combine
import SwiftUI

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
    @Published var currentResultTraining: [TrainingResultEntity] = []
    
    //MARK: Today section
    @Published var todayTrainingSheet: [TrainingEntity] = []
    @Published var todayGoals: [GoalEntity] = []
    @Published var selectedToday: GoalEntity? = nil
    @Published var goalToShow: GoalEntity? = nil
    @Published var selectedResultsToday: [TrainingResultEntity] = []
    @Published var todayResultFilter: PresentationDetent = .medium
    @Published var selectedTraining: TrainingEntity? = nil
    @Published var resultsToday: [TrainingResultEntity] = []
    @Published var temporaryMillisecods: Int64 = 0
    @Published var update: Bool = false
    
    
    //MARK: Combine
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getGoals()
        
        $selectedToday
            .combineLatest($todayGoals)
            .map(filterToday)
            .sink { [weak self] goal in
                self?.goalToShow = goal
                self?.getTodayTrainingFromTodayGoal(for: goal)
            }
            .store(in: &cancellables)
        
        $resultsToday
            .combineLatest($todayResultFilter, $update)
            .map(filterResultToday)
            .sink { [weak self] results in
                print("filter \(self?.todayResultFilter == .medium ? "medium" : "full")")
                self?.selectedResultsToday = results
            }
            .store(in: &cancellables)
    }
    
    func checkSportSelection() -> Bool {
        guard selectedSport != 0 else { return false }
        return true
    }
    
    func saveNewGoal() {
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
        newGoal.targetTime = calculateMilliseconds(hour: 0, minute: 1, second: 1, millisecond: 1)
    }
    //TODO: complete
    func calculateMilliseconds(hour: Int, minute: Int, second: Int, millisecond: Int) -> Int64 {
        return Int64((hour * 3600000) + (minute * 60000) + (second * 1000) + millisecond)
    }
    
    //TODO: complete
    private func cleanNewGoalSetup() {
        
    }
    
    private func getGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            allGoals = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    func saveTraining(selectedGoal: GoalEntity) {
        for step in newTrainingStep {
            selectedGoal.addToTrainings(step)
                for repetition in 0..<step.repeatCountTotal {
                    print("dentro a for")
                    step.addToResults(createResult(number: repetition + 1))
                }
        }
        //TODO: update current training sheet
        saveTraining(goal: selectedGoal)
    }
    
    func saveNewTrainingStep(trainingType: TrainingType, repeatCountTotal: Int, target: Int, dueDate: Date) {
        let newTraining = TrainingEntity(context: manager.context)
        newTraining.id = UUID()
        if trainingType == .exercise {
            newTraining.isExcercise = true
            newTraining.target = Int16(target)
        }
        newTraining.repeatCountTotal = Int16(repeatCountTotal)
        newTraining.dueDate = dueDate
        newTraining.repeatCountActual = 0
        currentTrainingSheet.append(newTraining) //TODO: sorting
        newTrainingStep.append(newTraining)
    }
    
    private func createResult(number: Int16) -> TrainingResultEntity {
        let newResult = TrainingResultEntity(context: manager.context)
        newResult.id = UUID()
        newResult.number = number
        newResult.result = 0
        return newResult
    }
    
    
    //TODO: complete
    private func cleanNewTrainingSetup() {
        
    }
    
    func getTrainingSheet(for goal: GoalEntity) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        let filter = NSPredicate(format: "goal == %@", goal)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        print("get training sheet for \(goal.sportID)")
        do {
            currentTrainingSheet = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    func getResult(for training: TrainingEntity) {
        let request = NSFetchRequest<TrainingResultEntity>(entityName: "TrainingResultEntity")
        let filter = NSPredicate(format: "training == %@", training)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingResultEntity.number, ascending: true)
        request.sortDescriptors = [sort]
        
        
        do {
            currentResultTraining = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    func updateResult(resultNumber: Int16, newResult: Int64, training: TrainingEntity, onSave: Bool) {
        let resultNumber = onSave ? resultNumber : resultNumber - 1
        if let index = selectedResultsToday.firstIndex(where: { $0.number == resultNumber }) {
            selectedResultsToday[index].result = Int64(newResult)
            training.repeatCountActual += 1
            print("training result: \(selectedResultsToday[index].result)")
            print("training array result: \(selectedResultsToday)")
            update.toggle()
        }
    }
    
    
    
    func saveResults() {
        saveResult()
        getTodayGoals()
    }
    
    private func saveGoal() {
        allGoals.removeAll()
        todayGoals.removeAll()
        todayTrainingSheet.removeAll()
        
        self.manager.save()
        self.getGoals()
        self.getTodayGoals()
    }
    
    func getTodayGoals() {
        print("getTodayGoals")
        selectedToday = nil
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
                selectedToday = todayGoals.first
            } catch let error {
                print("Error fetching coredata: \(error.localizedDescription)")
            }
        }
    }
    
    private func getTodayTrainingFromTodayGoal(for todayGoal: GoalEntity?) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        if let goal = todayGoal {
            let dateFrom = Calendar.current.startOfDay(for: Date())
            if let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom) {
                let filterGoal = NSPredicate(format: "goal == %@", goal)
                let fromFilter = NSPredicate(format: "ANY dueDate >= %@", dateFrom as CVarArg)
                let toFilter = NSPredicate(format: "ANY dueDate < %@", dateTo as CVarArg)
                let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [filterGoal, fromFilter, toFilter])
                request.predicate = filter
                
                let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
                request.sortDescriptors = [sort]
                
                do {
                    todayTrainingSheet = try manager.context.fetch(request)
                } catch let error {
                    print("Error fetching coredata: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func filterToday(selectedGoal: GoalEntity?, todayGoals: [GoalEntity]) -> GoalEntity? {
        if let selectedGoal = selectedGoal {
            return todayGoals.first(where: { $0.id == selectedGoal.id })
        }
        return todayGoals.first
    }
    
    func getResultFromTodayTraining(for training: TrainingEntity) {
        let request = NSFetchRequest<TrainingResultEntity>(entityName: "TrainingResultEntity")
        let filter = NSPredicate(format: "training == %@", training)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingResultEntity.number, ascending: true)
        request.sortDescriptors = [sort]
        
        
        do {
            resultsToday = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    private func filterResultToday(results: [TrainingResultEntity], filter: PresentationDetent, update: Bool) -> [TrainingResultEntity] {
        print("inside filterResultToday")
        if filter == .medium {
            if let result = results.first(where: { $0.result == 0 }) {
                print("filter today medium result: \(result)")
                return [result]
            }
        }
        print("filter today full")
        return results.filter( { $0.result == 0 } )
    }
    
    
 
    private func saveTraining(goal: GoalEntity) {
        currentTrainingSheet.removeAll()
        newTrainingStep.removeAll()
        self.manager.save()
        self.getTrainingSheet(for: goal)
    }
    
    private func saveResult() {
        self.manager.save()
    }
}
