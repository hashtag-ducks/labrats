Labrats.Views.BoxTemplate = Backbone.View.extend({
    initialize: function() {
        this.render();
    },

    save: function(event) {
        event.preventDefault();
        this.model.save({}, {
            url: "/box_templates/" + this.model.get('id')
        });
    }
});
