Labrats.Views.BoxTemplate = Backbone.View.extend({
    initialize: function() {
        this.render();
    },

    delete: function(event) {
        event.preventDefault();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    },

    save: function(event) {
        event.preventDefault();
        this.model.save({}, {
            url: "/box_templates/" + this.model.get('id')
        });
    }
});
