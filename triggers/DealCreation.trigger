trigger DealCreation on Opportunity (after update) {
    List<Deal__c> dealsToInsert = new List<Deal__c>();
    List<Opportunity> opportunities = new List<Opportunity>(
    [SELECT Id, Name, StageName, AccountId, Description FROM Opportunity WHERE StageName='Closed Won' AND Id IN :Trigger.New]);

    if (opportunities != null && opportunities.size() > 0) {
        for (Opportunity opportunity : opportunities) {
            Deal__c relatedDeal = new Deal__c();
            relatedDeal.Description__c = 'Automaticly generated by ' + opportunity.Name + ' opportunity'+ ', because it has been ' + opportunity.StageName;
            relatedDeal.Account__c = opportunity.AccountId;
            relatedDeal.Opportunity__c = opportunity.Id;
            //System.debug('New Deal has been created: ' + relatedDeal);
            dealsToInsert.add(relatedDeal);
        }
        insert dealsToInsert;
    }
}