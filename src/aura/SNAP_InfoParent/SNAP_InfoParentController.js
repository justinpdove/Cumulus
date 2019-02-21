/**
 * Created by justin.dove on 2/21/19.
 */
({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactInfosById");
        action.setParams({
            "contactId": component.get("v.recordId")
        });

        action.setCallback(this, function(response) {
            var wrapper = response.getReturnValue();
            component.set("v.infoWrapper", wrapper);
        });

        $A.enqueueAction(action);
    }
})