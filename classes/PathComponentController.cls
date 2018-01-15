public with sharing class PathComponentController {

    public Opportunity currentOpportunity;
    private List<OpportunityStage> availableStages;
    private Integer indexOfCurrentStage;
    private List<String> allStages;
    private List<String> passedStages;
    private List<String> futureStages;
    public String clickedStage;


    public PathComponentController() {
        availableStages = [SELECT Id, ApiName FROM OpportunityStage ORDER BY SortOrder];
        /* Create list of strings for all stages */
        allStages = new List<String>();
        for (OpportunityStage stage : availableStages) {
            allStages.add(stage.ApiName);
        }

    }

    private void sendEmailToUser() {
        EmailManager.sendMail(UserInfo.getUserEmail(), 'Opportunity with ID ' + currentOpportunity.Id + ' was closed.', currentOpportunity.Id + ' was closed!!');
    }

    /* Create index of current stage and passed stages list */
    private void initPassedStages() {
        passedStages = new List<String>();
        for (Integer i = 0; i < allStages.size() ; i++) {
            if (!allStages.get(i).equalsIgnoreCase(currentOpportunity.StageName)) {
                passedStages.add(allStages.get(i));
            } else {
                indexOfCurrentStage = i;
                break;
            }
        }
        if (currentOpportunity.StageName.equalsIgnoreCase('Closed Lost')) {
            passedStages.remove(passedStages.size() - 1);
        }
    }

    /* Create future stages list */
    private void initFutureStages() {
        futureStages = new List<String>(allStages);
        for (Integer i = 0; i <= indexOfCurrentStage; i++) {
            futureStages.remove(0);
        }
        /*Merge 'close WON' and 'close LOST' stages into 'Close' */
        if (futureStages.size() >= 2) {
            futureStages.remove(futureStages.size() - 1);
            futureStages.remove(futureStages.size() - 1);
            futureStages.add('Closed');
        } else {
            futureStages.clear();
        }

    }

    public void setCurrentOpportunity(Opportunity Opportunity) {
        this.currentOpportunity = Opportunity;
    }

    public Opportunity getCurrentOpportunity() {
        return this.currentOpportunity;
    }

    public List<String> getAllStages() {
        return allStages;
    }

    public List<String> getPassedStages() {
        initPassedStages();
        return passedStages;

    }

    public List<String> getFutureStages() {
        initFutureStages();
        return futureStages;

    }

    public Integer getIndexOfCurrentStage() {
        return indexOfCurrentStage;
    }

    public String getCurrentStageName() {
        return currentOpportunity.StageName;
    }

    public String getClickedStage() {
        return clickedStage;
    }

    public void setClickedStage(String newStage) {
        this.clickedStage = newStage;
    }


    public PageReference nextStage() {
        if (clickedStage.equalsIgnoreCase('Closed') && currentOpportunity.StageName.equalsIgnoreCase(allStages.get(allStages.size() - 3))) {
            //TODO IF we need won or lose logic needs js window
            indexOfCurrentStage = allStages.size() - 2;
            currentOpportunity.StageName = allStages.get(allStages.size() - 2);

            sendEmailToUser();

        } else if (clickedStage != null && clickedStage.equalsIgnoreCase(allStages.get(indexOfCurrentStage + 1))) {
                ++indexOfCurrentStage;
                currentOpportunity.StageName = allStages.get(indexOfCurrentStage);

        }
        update currentOpportunity;
        /*PageReference pageRef = new PageReference('/' + ApexPages.currentPage().getParameters().get('id') );
        pageRef.setRedirect(true);*/
        return null;
    }
}