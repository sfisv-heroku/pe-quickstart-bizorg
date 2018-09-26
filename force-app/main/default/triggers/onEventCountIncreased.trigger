 /*
 * Copyright (c) 2018, Salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root
 */
 
 trigger onEventCountIncreased on EventCountIncreased__e (after insert) {

    Map<String, Integer> eventIncreaseByOrg = new Map<String, Integer>();
    Integer eventIncrease;
    List<Customer_Org_Info__c> customerOrgs;
    
    // Iterate through the events, and for each orgId, set the approprate number of events 
    for (EventCountIncreased__e event : Trigger.New) {
        // Get the cached value from the map
        eventIncrease = eventIncreaseByOrg.get(event.Org_Id__c); 
        
        // If not there, then set to 1, otherwise, increase by 1 
        eventIncrease = (eventIncrease == null) ? 1 : eventIncrease + 1;
        
        // Set the new value, to be used later
        eventIncreaseByOrg.put(event.Org_Id__c, eventIncrease);   
    }
    
    customerOrgs = [SELECT Org_Id__c, EventCount__c FROM Customer_Org_Info__c WHERE Org_Id__c IN: eventIncreaseByOrg.keySet()];
    
    for (Customer_Org_Info__c customerOrg : customerOrgs) {
        // Get the cached number of events to increase by
        eventIncrease = eventIncreaseByOrg.get(customerOrg.Org_Id__c);
        
        // Increase the EventCount by that number
        customerOrg.EventCount__c = customerOrg.EventCount__c + eventIncrease;
    }
    
    // Update all customer org records.
    update customerOrgs;

}