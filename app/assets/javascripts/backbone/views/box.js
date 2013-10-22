Labrats.Views.Box = Backbone.View.extend({
    initialize: function() {
        this.render();
    },

    delete: function(event) {
        event.preventDefault();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    }
});
