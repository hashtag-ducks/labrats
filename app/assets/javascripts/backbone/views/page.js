/*
* Abstract -- subclassed by PageTemplate and FilledPage.
*/
Labrats.Views.Page = Backbone.View.extend({
    render: function() {
        var tpl = $(this.templateName).text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    },

    initialize: function() {
        this.render();
        var self = this;
        this.model.get(this.childSelector).forEach(function(tabGroup) {
            var ele = $('<li></li>');
            self.$el.find('ul.tab-groups').append(ele);
            var view = new Labrats.Views[self.childType]({
                model: tabGroup,
                el: ele
            });
        });
    }
});
