Labrats.Views.PageTemplate = Backbone.View.extend({
    events: {
        'click .new-tab-group': 'newTabGroup',
        'click .delete-page': 'delete'
    },

    initialize: function() {
        this.render();
    },

    render: function() {
        var tpl = $('#page-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            is_owner: this.model.get('is_owner')
        }));
        var self = this;
        this.model.get('tab_group_templates').forEach(function(tabGroup) {
            var ele = $('<li></li>');
            self.$el.find('ul.tab-groups').append(ele);
            var view = new Labrats.Views.TabGroupTemplate({
                model: tabGroup,
                el: ele
            });
        });
    },

    newTabGroup: function(event) {
        event.preventDefault();
        var tab_group_model = new Labrats.Models.TabGroupTemplate({
            page_template_id: this.model.get('id')
        });
        var self = this;
        tab_group_model.save({}, {
            success: function(response) {
                tab_group_model = new Labrats.Models.TabGroupTemplate(
                    _.extend({is_owner: true}, response.attributes)
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
    },

    delete: function(event) {
        event.preventDefault();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    }
});
