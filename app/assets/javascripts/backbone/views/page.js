Labrats.Views.Page = Backbone.View.extend({
    initialize: function() {
        this.render();
        var self = this;
        this.model.get('tab_groups').forEach(function(tab_group) {
            var ele = $('<li></li>');
            self.$el.find('ul.tab-groups').append(ele);
            var view = new Labrats.Views.TabGroup({
                model: tab_group,
                el: ele
            });
        });
    },

    render: function() {
        var tpl = $('#page-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    }
});
