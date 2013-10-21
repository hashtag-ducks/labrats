Labrats.Models.Page = Backbone.Model.extend({
    url: function() {
        return '/notebooks/' + this.get('notebook_id') + '/pages';
    },

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
    },

    // See Labrats.Models.Notebook
    parse: function(response) {
        response.tab_groups = new Labrats.Collections.TabGroups(
            _.map(response.tab_groups, function(tab_group_JSON) {
                return new Labrats.Models.TabGroup(tab_group_JSON, {parse: true});
            })
        );
        return response;
    }
});
