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
        guard
        
            let directory:URL = MSave.projectsDirectory()
        
        else
        {
            return
        }
        
        var items:[MHomeItem] = []
        
        for project:DProject in projects
        {
            guard
                
                let name:String = project.name
            
            else
            {
                continue
            }
            
            let path:URL = directory.appendingPathComponent(name)
            let item:MHomeItem = MHomeItem(
                project:project,
                path:path)
            items.append(item)
        }
        
        itemsLoaded(items:items)
    }
}
