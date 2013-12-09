Labrats.Views.NotebookIndex = Backbone.View.extend({
    events: {
        'click #new-notebook': 'showNotebook'
    },

    showNotebook: function(event) {
        event.preventDefault();
        this.$el.find('.new-notebook-form').toggleClass('hidden');
    }
});
