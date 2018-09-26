// Get the 'Platform Event App' Connected Application
ConnectedApplication connApp = [SELECT Id, Name, OptionsAllowAdminApprovedUsersOnly FROM ConnectedApplication WHERE Name = 'CustomerOrgInformation'];

// Set the OptionsAllowAdminApprovedUsersOnly to true
// connApp.OptionsAllowAdminApprovedUsersOnly = true; // Would do this, but field not writable
// update connApp;

// Add the PE_Example_Access PermissionSet to the 'Platform Event App' Connected App
PermissionSet permSet = [SELECT Id, Name FROM PermissionSet WHERE Name = 'PE_Example_Access'];
SetupEntityAccess entAccess = new SetupEntityAccess(parentId=permSet.Id, SetupEntityId=connApp.Id);
insert entAccess;


