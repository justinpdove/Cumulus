public with sharing class SNAP_ContactWrapper {
    @AuraEnabled public List<FieldWrapper> fields;
    @AuraEnabled public Contact record;

    public SNAP_ContactWrapper(Contact con, Schema.FieldSet fieldSet) {
        this.record = con;
        this.fields = new List<FieldWrapper>();
        for(Schema.FieldSetMember field : fieldSet.getFields()) {
            fields.add(new FieldWrapper(field));
        }
    }

    public class FieldWrapper {
        @AuraEnabled public String fieldName;
        @AuraEnabled public String fieldLabel;

        public FieldWrapper(Schema.FieldSetMember field) {
            this.fieldLabel = field.getLabel();
            this.fieldName = field.getFieldPath();
        }
    }
}