Labrats.Views.PageTemplate = Labrats.Views.Page.extend({
    templateName: '#page_template-tpl',

    childType: 'TabGroupTemplate',
    childSelector: 'tab_group_templates',

    events: {
        'click .new-tab-group': 'newTabGroup'
    },

    newTabGroup: function(event) {
        event.preventDefault();
        var tab_group_model = new Labrats.Models.TabGroupTemplate({
            page_template_id: this.model.get('id')
        });
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        var self = this;
        tab_group_model.save({}, {
            success: function(response) {
                tab_group_model = new Labrats.Models.TabGroupTemplate(
                    response.attributes
                );
                var tabGroupEle = $('<li></li>');
                self.$el.find('.tab-groups').append(tabGroupEle);
                var tabGroupView = new Labrats.Views.TabGroupTemplate({
                    model: tab_group_model,
                    el: tabGroupEle
                });
                self.model.get('tab_group_templates').add(tab_group_model);
            },
            error: function() {
                console.log('error saving tab_group');
            }
        });
    }
});
