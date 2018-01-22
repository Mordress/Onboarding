public with sharing class AngularComponentController {

	public Opportunity incomeOpportunity {get; set;}
	public static final String NON_EXISTS_DEAL = 'N/A';
	private Deal__c relatedDeal {get; set;}
	private Opportunity currentOpportunity;

	private Boolean init() {
		try {
			currentOpportunity = [SELECT Name, StageName, IsWon, IsClosed FROM Opportunity WHERE Id =:incomeOpportunity.Id];
			/*System.debug('incomeOpportunity: ' + incomeOpportunity);*/
			System.debug('Opportunity: ' + currentOpportunity);
			if (currentOpportunity.IsWon) {
				relatedDeal = [SELECT Id, Name, Description__c, Approval_Status__c FROM Deal__c WHERE Opportunity__c =:incomeOpportunity.Id];
				System.debug('Deal: ' + relatedDeal);
			} else return false;
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



	/*private Boolean isWonedOpportunity() {
		return [SELECT IsWon FROM Opportunity WHERE Id =:incomeOpportunity.Id];
	}*/

	/*private Boolean initDeal() {
		try {
			relatedDeal = [SELECT Id, Name, Description__c, Approval_Status__c FROM Deal__c WHERE Opportunity__c =:incomeOpportunity.Id];
			System.debug(relatedDeal);
		} catch (DmlException e) {
			System.debug(e.getCause());
			return false;
		}
		return true;
	}*/

	/*public String getDealName() {
		if (initDeal() && relatedDeal != null) {
			return relatedDeal.Name;
		}
		return 'N/A';
	}*/

	/*public String getDealDesc() {
		if (relatedDeal == null) {
			if (!initDeal()) {
				return 'N/A';
			}
		}
		return relatedDeal.Description__c;
	}*/
}