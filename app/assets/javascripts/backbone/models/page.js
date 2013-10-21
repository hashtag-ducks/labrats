Labrats.Models.Page = Backbone.Model.extend({
    urlRoot: '/pages',

    defaults: {
        notebook_id: 0
    },

    toJSON: function() {
        return {
            page: this.attributes
        };
    },

    validate: function(attrs) {
        if(attrs.notebook_id === 0) {
            return "Notebook ID can't be 0";
        }
    }
});
