/**
 * Class for retrieving information for Donor Snapshot header components.
 */

public class SNAP_HeaderComponentController {

    public class HeaderInfosWrapper {
        @AuraEnabled public Contact contact;
        @AuraEnabled public Map<String, String> fieldMap;
    }

    @AuraEnabled
    public static HeaderInfosWrapper getContactInfosById(Id contactId) {
        List<Schema.FieldSetMember> contactSnapFieldSetMembers = Schema.SObjectType.Contact.fieldSets.SNAP_InfoDetails.getFields();
        String queryString;
        Map<String, String> fieldsByApiNameMap = new Map<String, String>();

        if(!contactSnapFieldSetMembers.isEmpty()) {
            queryString = 'SELECT Name';
            for (Schema.FieldSetMember fieldMember : contactSnapFieldSetMembers) {
                queryString += ', ' + fieldMember.getFieldPath();
                fieldsByApiNameMap.put(fieldMember.getFieldPath(), fieldMember.getLabel());
            }
            queryString += ' FROM Contact WHERE Id = :contactId LIMIT 1';
        }

        System.debug('>>>>> Query string: ' + queryString);
        Contact contact = Database.query(queryString);

//        return contact;

        HeaderInfosWrapper infosWrapper = new HeaderInfosWrapper();
        infosWrapper.contact = contact;
        infosWrapper.fieldMap = fieldsByApiNameMap;

        return infosWrapper;
    }

}