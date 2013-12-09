// Calling this AbstractBox because the way we instantiate boxes in JS
// requires that their class names match up with the Rails models that
// they're based off of and I don't want to change those names.

Labrats.Views.AbstractBox = Backbone.View.extend({
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
            url: this.url()
        });
    }
});
