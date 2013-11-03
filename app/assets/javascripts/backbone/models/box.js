Labrats.Models.Box = Backbone.Model.extend({
    url: function() {
        return '/boxes/' + this.get('id');
    },

    defaults: {
        tab_group_id: 0
    },

    toJSON: function() {
        return {
          box: this.attributes  
        };
    },

    validate: function(attrs) {
        if(attrs.tab_group_id === 0) {
            return "Tab group template ID can't be 0";
        }
    }
});
