public with sharing class PathComponentController {

    public Opportunity currentOpportunity;
    private List<OpportunityStage> availableStages;
    private Integer indexOfCurrentStage;
    private List<String> allStages;
    private List<String> passedStages;
    private List<String> futureStages;


    public PathComponentController() {
        availableStages = [SELECT Id, ApiName FROM OpportunityStage ORDER BY SortOrder];
        /* Create list of strings for all stages */
        allStages = new List<String>();
        for (OpportunityStage stage : availableStages) {
            allStages.add(stage.ApiName);

        }

    }

    /* Create index of current stage in list of all stages and passed stages list */
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
        /*Merge close WON and close LOST*/
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

}