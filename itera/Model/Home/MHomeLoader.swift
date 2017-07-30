import Foundation
import CoreData

extension MHome
{
    func load()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoad()
        }
    }
    
    //MARK: private
    
    private func asyncLoad()
    {
        DManager.sharedInstance?.fetch(entity:DProject.self)
        { [weak self] (data:[NSManagedObject]?) in
        
            guard
            
                var projects:[DProject] = data as? [DProject]
            
            else
            {
                return
            }
            
            projects.sort
            { (projectA:DProject, projectB:DProject) in
                
                return projectA.created < projectB.created
            }
            
            self?.projectsLoaded(projects:projects)
        }
    }
    
    private func projectsLoaded(projects:[DProject])
    {
        
    }
}
