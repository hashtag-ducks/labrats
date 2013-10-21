Labrats.Views.TabGroup = Backbone.View.extend({
    events: {
        'click .new-box': 'newBox',
        'click .delete-tab-group': 'delete'
    },

    initialize: function() {
        this.render();
    },

    render: function() {
        var tpl = $('#tab_group-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    },

    newBox: function(event) {
        event.preventDefault();
    },

    delete: function(event) {
        event.preventDefault();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    }
});
