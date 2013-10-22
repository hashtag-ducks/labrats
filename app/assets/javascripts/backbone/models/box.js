Labrats.Models.Box = Backbone.Model.extend({
    url: function() {
        return '/tab_groups/' + this.get('tab_group_id') + '/boxes';
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
            return "Tab group ID can't be 0";
        }
    }
});
