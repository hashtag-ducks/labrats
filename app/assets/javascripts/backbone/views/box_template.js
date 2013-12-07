Labrats.Views.BoxTemplate = Backbone.View.extend({
    initialize: function() {
        this.render();
    },

    save: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        this.model.save({}, {
            url: "/box_templates/" + this.model.get('id')
        });
    }
});
