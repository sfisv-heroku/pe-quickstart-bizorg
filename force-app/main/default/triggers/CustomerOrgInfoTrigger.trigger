/*
 * Copyright (c) 2018, Salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root
 */
 
trigger CustomerOrgInfoTrigger on Customer_Org_Info__c (before insert, before update, after insert, after update) {

    if (trigger.isBefore) {
        for (Customer_Org_Info__c orgInfo : Trigger.new) {
            // Fix the quotes in the ConnectionInfo string
            orgInfo.ConnectionInfo__c = orgInfo.ConnectionInfo__c.replace('\'', '\"'); 
        }
    }
  

    if (trigger.isAfter) {

        List<UpdatedCustomerOrgInfo__e> eventList = new List<UpdatedCustomerOrgInfo__e>();

        // Iterate through the updated CustomerOrgInfo's and create an Event for each one   
        for (Customer_Org_Info__c orgInfo : Trigger.new) {
            
            if (trigger.isInsert || ( trigger.isUpdate && 
                    ( (orgInfo.IsActive__c != Trigger.oldMap.get(orgInfo.Id).IsActive__c) || 
                    (orgInfo.ConnectionInfo__c != Trigger.oldMap.get(orgInfo.Id).ConnectionInfo__c) ) ) ) {
                UpdatedCustomerOrgInfo__e newEvent = new UpdatedCustomerOrgInfo__e(
                        OrgId__c=orgInfo.Org_Id__c, Data__c=orgInfo.ConnectionInfo__c, IsActive__c=orgInfo.IsActive__c);
                eventList.add(newEvent);
            }
        }

        // Publish newly created events
        List<Database.SaveResult> results = EventBus.publish(eventList);
     }

}