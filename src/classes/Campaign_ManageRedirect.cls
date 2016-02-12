public with sharing class Campaign_ManageRedirect {
    public ApexPages.StandardController controller;
    public Id controllerId { get; set; }
    
    public Campaign_ManageRedirect(ApexPages.StandardController controller) {
        this.controller = controller;
        this.controllerId = controller.getId();
    }

    public PageReference initialize() {
        Campaign campaign = (Campaign) controller.getRecord();

        // Add record type id if missing
        if (getParam('RecordType', null) == null && campaign.RecordTypeId != null) {
            putParam('RecordType', campaign.RecordTypeId);
        }

        // Find the record type name
        RecordType[] recordTypeList = [
            SELECT Name
              FROM RecordType
             WHERE Id = :getParam('RecordType', null)
             LIMIT 1
        ];

        // No match?
        if (recordTypeList.isEmpty()) {
            return redirectToEdit();
        }

        // Where do we go?
        if ('Event'.equalsIgnoreCase(recordTypeList[0].Name)) {
            return redirectTo(System.Page.Campaign_ManageEvent);
        }

        if ('Volunteer Project'.equalsIgnoreCase(recordTypeList[0].Name)) {
            return redirectTo(System.Page.Campaign_ManageVolunteerProject);
        }

        return redirectToEdit();
    }

    public PageReference redirectToEdit() {
        PageReference pageReference = new PageReference(controllerId == null ? '/701/e' : '/' + controllerId + '/e');
        pageReference.getParameters().put('RecordType', getParam('RecordType', null));
        pageReference.getParameters().put('nooverride', '1');
        pageReference.getParameters().put('retURL', getParam('retURL', null));
        pageReference.getParameters().remove('sdfc.override');
        pageReference.setRedirect(true);

        return pageReference;
    }

    public PageReference redirectTo(PageReference pageReference) {
        pageReference.setRedirect(true);
        pageReference.getParameters().put('retURL', getParam('retURL', null));
        pageReference.getParameters().put('RecordType', getParam('RecordType', null));

        
        return pageReference;
    }
    
    public void putParam(PageReference pageReference, String param) {
        if (getParam(param, null) != null) {
            pageReference.getParameters().put(param, getParam(param));
        }
    }
    
    public virtual String getParam(String paramName, String defaultValue) {
        system.assert(ApexPages.currentPage() != null, 'ApexPages.currentPage() == null');
        system.assert(ApexPages.currentPage().getParameters() != null, 'ApexPages.currentPage().getParameters() == null');
        String param = ApexPages.currentPage().getParameters().get(paramName);
        return param == null ? defaultValue : param;
    }
    
    public virtual String getParam(String paramName) {
        return getParam(paramName, '');
    }
    
    public virtual void putParam(String paramName, String paramData) {
        system.assert(ApexPages.currentPage() != null, 'ApexPages.currentPage() == null');
        system.assert(ApexPages.currentPage().getParameters() != null, 'ApexPages.currentPage().getParameters() == null');
        ApexPages.currentPage().getParameters().put(paramName, paramData);
    }
}