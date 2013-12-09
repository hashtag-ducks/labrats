Labrats.Views.BoxTemplate = Backbone.View.extend({
    url: function() {
       return "/box_templates/" + this.model.get('id');
    }
});
