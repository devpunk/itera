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
        let shouldUpdate:Bool = shouldUpdateProjects(
            projects:projects)
        
        if shouldUpdate
        {
            updateProjects(projects:projects)
        }
    }
    
    private func updateProjects(projects:[DProject])
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
    
    private func shouldUpdateProjects(projects:[DProject]) -> Bool
    {
        let currentMap:[NSManagedObjectID:Int] = currentProjectsMap()
        let map:[NSManagedObjectID:Int] = projectsMap(projects:projects)
        
        for project in projects
        {
            let objectId:NSManagedObjectID = project.objectID
            
            if currentMap[objectId] == nil
            {
                return true
            }
        }
        
        for item in items
        {
            let objectId:NSManagedObjectID = item.project.objectID
            
            if map[objectId] == nil
            {
                return true
            }
        }
        
        return false
    }
    
    private func currentProjectsMap() -> [NSManagedObjectID:Int]
    {
        var map:[NSManagedObjectID:Int] = [:]
        
        for item in items
        {
            let objectId:NSManagedObjectID = item.project.objectID
            map[objectId] = 0
        }
        
        return map
    }
    
    private func projectsMap(projects:[DProject]) -> [NSManagedObjectID:Int]
    {
        var map:[NSManagedObjectID:Int] = [:]
        
        for project in projects
        {
            let objectId:NSManagedObjectID = project.objectID
            map[objectId] = 0
        }
        
        return map
    }
}
