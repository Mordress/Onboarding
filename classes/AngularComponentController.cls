public with sharing class AngularComponentController {

	private Deal__c relatedDeal {get; set;}
	private Opportunity currentOpportunity;
	public Opportunity incomeOpportunity {get; set;}
	public static final String NON_EXISTS_DEAL = 'N/A';

	private Boolean init() {
		try {
			currentOpportunity = [SELECT Name, StageName, IsWon, IsClosed FROM Opportunity WHERE Id =:incomeOpportunity.Id];
			/*System.debug('incomeOpportunity: ' + incomeOpportunity);*/
			System.debug('Opportunity: ' + currentOpportunity);
			if (currentOpportunity.IsWon) {
				relatedDeal = [SELECT Id, Name, Description__c, Approval_Status__c, CreatedDate FROM Deal__c WHERE Opportunity__c =:incomeOpportunity.Id];
				System.debug('Deal: ' + relatedDeal);
			} else {
                return false;
            }
		} catch (QueryException e) {
			System.debug(e.getMessage()+ ' ' + e.getCause());
			return false;
		}
		return true;
	}

	public String getDealName() {
		if (init()) {
			return relatedDeal.Name;
		}
		return NON_EXISTS_DEAL;
	}

	public String getDealDesc() {
		if (init()) {
			return relatedDeal.Description__c;
		}
		return NON_EXISTS_DEAL;
	}

	public String getDealStatus() {
		if (init()) {
			return relatedDeal.Approval_Status__c;
		}
		return NON_EXISTS_DEAL;
	}

	public String getDealCreateDate() {
		if (init()) {
			return Date.newInstance(relatedDeal.CreatedDate.year(),
                                    relatedDeal.CreatedDate.month(),
                                    relatedDeal.CreatedDate.day())
                                    .format();
		}
		return NON_EXISTS_DEAL;
	}
}