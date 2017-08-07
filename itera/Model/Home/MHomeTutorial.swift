import Foundation
import CoreData

extension MHome
{
    func tutorialCheck(projects:[DProjectUser])
    {
        if projects.count > 0
        {
            projectsLoaded(projects:projects)
        }
        else
        {
            addTutorial(projects:projects)
        }
    }
    
    //MARK: private
    
    private func addTutorial(projects:[DProjectUser])
    {
        DManager.sharedInstance?.fetch(
            entity:DProjectTutorial.self)
        { [weak self] (data:[NSManagedObject]?) in
            
            guard
            
                let tutorials:[DProjectTutorial] = data as? [DProjectTutorial]
            
            else
            {
                return
            }
            
            self?.merge(
                projects:projects,
                tutorials:tutorials)
        }
    }
    
    private func merge(
        projects:[DProjectUser],
        tutorials:[DProjectTutorial])
    {
        var merged:[DProject] = []
        
        for tutorial:DProjectTutorial in tutorials
        {
            merged.append(tutorial)
        }
        
        for project:DProject in projects
        {
            merged.append(project)
        }
        
        projectsLoaded(projects:merged)
    }
}
