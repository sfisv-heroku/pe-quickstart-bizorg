/*
 * Copyright (c) 2018, Salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root
 */
 
trigger onCustomerOrgActivity on CustomerOrgActivity__e (after insert) {

    Map<String, CustomerOrgActivity__e> customerActivityByOrg = new Map<String, CustomerOrgActivity__e>();
    List<Customer_Org_Info__c> customerOrgs;
    
    // Iterate through the events, and organize the most recent ones into a map, key'd by orgId
    for (CustomerOrgActivity__e event : Trigger.New) {
        // Get the cached value from the map, if there is one
        CustomerOrgActivity__e other = customerActivityByOrg.get(event.OrgId__c); 

        // If there is no existing value, or if the existing one is older, then save the current in the map
        if ((other == null) || (event.createdDate > other.createdDate)) {
            // Set the new value, to be used later
            customerActivityByOrg.put(event.OrgId__c, event);         
        }
    }
    
    customerOrgs = [SELECT Org_Id__c, EventCount__c FROM Customer_Org_Info__c WHERE Org_Id__c IN: customerActivityByOrg.keySet()];
     
    for (Customer_Org_Info__c customerOrg : customerOrgs) {
        // Get the event for this org
        CustomerOrgActivity__e activity = customerActivityByOrg.get(customerOrg.Org_Id__c);

        // Currently, only handling 'Subscription' type, but could be extended to handle EventCountIncreased and replace more specific Event/trigger
        if (activity.Type__c == 'Subscription') {       
            // Set the fields on the Customer_Org_Info__c record
            //Long longtime = Long.valueOf(activity.timestamp);
            customerOrg.LastConnectionDate__c = activity.createdDate; // DateTime.newInstance(longtime);
            customerOrg.LastConnectionSuccess__c = activity.Success__c; //(activity.Success__c == 1) ? true : false;
        }
    }
    
    // Update all customer org records.
    update customerOrgs;

}